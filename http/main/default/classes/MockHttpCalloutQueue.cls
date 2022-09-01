@IsTest
public class MockHttpCalloutQueue implements HttpCalloutMock {
    private List<RequestAndResponsePair> expectedRequestsAndResponses = new List<RequestAndResponsePair>();
    private List<RequestAndResponsePair> anyRequestsAndResponses = new List<RequestAndResponsePair>();
    private List<HttpRequest> actualExpectedRequests = new List<HttpRequest>();
    private Integer requestCount = 0;

    public MockHttpCalloutQueue expect(HttpRequest request, HttpResponse response) {
        this.expectedRequestsAndResponses.add(new RequestAndResponsePair(request, response));
        return this;
    }

    public MockHttpCalloutQueue expect(HttpRequest request, Exception exceptionResponse) {
        this.expectedRequestsAndResponses.add(new RequestAndResponsePair(request, exceptionResponse));
        return this;
    }

	// Effectively a stub ... allow any amount of these calls and return canned response
    public MockHttpCalloutQueue any(HttpRequest request, HttpResponse response) {
        this.anyRequestsAndResponses.add(new RequestAndResponsePair(request, response));
        return this;
    }

    public HttpResponse respond(HttpRequest request) {
        this.requestCount++;
        Object response = matchExpectedRequest(request);
        if (response == null) {
            List<Object> errorParameters = new List<Object> { request.getMethod(), request.getEndpoint() };
            throw new MockHttpCalloutException(String.format('HTTP callout not supported for [{0}] to [{1}]', errorParameters));
        }

        if (response instanceof Exception) {
            throw (Exception) response;
        }

        return (HttpResponse) response;
    }

    public Boolean verifyExpectations() {
        return this.expectedRequestsAndResponses.size() == 0;
    }

    public Integer numberOfRequests() {
        return this.requestCount;
    }

    public HttpRequest getExpectedRequests(Integer requestNumber) {
        if (requestNumber < 0 || requestNumber > this.actualExpectedRequests.size()) {
            return null;
        }
        return this.actualExpectedRequests.get(requestNumber);
    }

    private Object matchExpectedRequest(HttpRequest request) {
        if (this.expectedRequestsAndResponses.size() > 0) {
            Object httpResponse = this.expectedRequestsAndResponses.get(0).matchRequest(request);
            if (httpResponse != null) {
                this.expectedRequestsAndResponses.remove(0);
                this.actualExpectedRequests.add(request);
                return httpResponse;
            }
        }

        return matchAnyRequest(request);
    }

    private Object matchAnyRequest(HttpRequest request) {
        Object httpResponse = null;
        for (RequestAndResponsePair requestResponsePair : this.anyRequestsAndResponses) {
            httpResponse = requestResponsePair.matchRequest(request);
            if (httpResponse != null) {
                break;
            }
        }

        return httpResponse;
    }

    public class RequestAndResponsePair {
        private HttpRequest request;
        private Object response;
        private List<String> headersToMatch = new List<String> {
            'Authorization',
            'Content-Type'
        };

        public RequestAndResponsePair(HttpRequest request, Object response) {
            this.request = request;
            this.response = response;
        }

        public Object matchRequest(HttpRequest request) {
            if (methodMatch(request) && uriMatch(request) && headerMatch(request) && bodyMatch(request)) {
                return this.response;
            }
            return null;
        }

        private Boolean methodMatch(HttpRequest request) {
            return request.getMethod() == this.request.getMethod();
        }

        private Boolean uriMatch(HttpRequest request) {
            if (request.getEndPoint() == this.request.getEndPoint()) {
                return true;
            }
            return false;
        }

        private Boolean headerMatch(HttpRequest request) {
            Boolean matches = true;
            for (String header : headersToMatch) {
                if (this.request.getHeader(header) != null && this.request.getHeader(header) != request.getHeader(header)) {
                    matches = false;
                    break;
                }
            }
            return matches;
        }

        private Boolean bodyMatch(HttpRequest request) {            
            if (String.isBlank(this.request.getBody())) {
                // We don't care about specific payload or it is too complicated to evaluate
                return true;
            }
            return this.request.getBody() == request.getBody();
        }
    }
    
    public class MockHttpCalloutException extends Exception {}
}