@IsTest
public class HttpFutureCalloutTest {
    public static final String REQUEST_ENDPOINT = 'https://test.com';
    public static final String REQUEST_METHOD = 'POST';
    public static final String REQUEST_BODY = '{ "hello":"world" }';
    public static final String HEADER_CONTENT_TYPE_NAME = 'Content-Type';
    public static final String HEADER_CONTENT_TYPE_VALUE = 'application/json';
    
   @IsTest
    public static void Given_RequestMade_When_Sent_Then_FutureCalloutWithCorrectRequest() {
        HttpRequest request = new HttpRequest();
        request.setMethod(REQUEST_METHOD);
        request.setEndpoint(REQUEST_ENDPOINT);
        request.setBody(REQUEST_BODY);
        request.setHeader(HEADER_CONTENT_TYPE_NAME, HEADER_CONTENT_TYPE_VALUE);
        MockHttpCalloutQueue queue = new MockHttpCalloutQueue().expect(request, httpCreated());
        Test.setMock(HttpCalloutMock.class, queue);

        Test.startTest();
        new HttpFutureCallout()
            .setMethod(REQUEST_METHOD)
            .setEndpoint(REQUEST_ENDPOINT)
            .setHeader(HEADER_CONTENT_TYPE_NAME, HEADER_CONTENT_TYPE_VALUE)
            .setBody(REQUEST_BODY)
            .send();
        Test.stopTest();

        System.assert(queue.verifyExpectations(), 'Callout was not made');
    }

    @IsTest
    public static void Given_RequestMade_When_ServiceUnavailable_Then_exceptionThrown() {
        HttpRequest request = new HttpRequest();
        request.setMethod(REQUEST_METHOD);
        request.setEndpoint(REQUEST_ENDPOINT);
        request.setBody(REQUEST_BODY);
        request.setHeader(HEADER_CONTENT_TYPE_NAME, HEADER_CONTENT_TYPE_VALUE);
        MockHttpCalloutQueue queue = new MockHttpCalloutQueue().expect(request, create503CalloutException());
        Test.setMock(HttpCalloutMock.class, queue);

        Boolean exceptionThrown = false;
        try
        {
            Test.startTest();
			new HttpFutureCallout()
            	.setMethod(REQUEST_METHOD)
         		.setEndpoint(REQUEST_ENDPOINT)
            	.setHeader(HEADER_CONTENT_TYPE_NAME, HEADER_CONTENT_TYPE_VALUE)
            	.setBody(REQUEST_BODY)
            	.send();
            Test.stopTest();
        } catch (CalloutException exc) {
            exceptionThrown = true;
        }
    
        System.assert(queue.verifyExpectations(), 'Callout was not made');
        System.assert(exceptionThrown, 'An exception was not thrown on service unavailable');
    }
    
    private static HttpResponse httpCreated() {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(201);
        return response;
    }
    
    private static CalloutException create503CalloutException() {
		CalloutException exc = (CalloutException)CalloutException.class.newInstance();
        exc.setMessage('Unable to tunnel through proxy. Proxy returns "HTTP/1.1 503 Service Unavailable"');
		return exc;
    }
}