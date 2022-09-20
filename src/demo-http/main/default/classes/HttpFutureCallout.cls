public class HttpFutureCallout {
    private static final Integer DEFAULT_TIMEOUT = 10000; // 10 seconds
    private Callout callout;

    public HttpFutureCallout() {
        this.callout = new Callout();
        this.callout.Timeout = DEFAULT_TIMEOUT;
    }

    public HttpFutureCallout setMethod(String method) {
        this.callout.HttpMethod = method;
        return this;
    }

    public HttpFutureCallout setEndpoint(String endpoint) {        
        this.callout.Endpoint = endpoint;
        return this;
    }

    public HttpFutureCallout setHeader(String key, String value) {
        this.callout.Headers.put(key, value);
        return this;
    }

    public HttpFutureCallout setBody(String body) {
        this.callout.Body = body;
        return this;
    }

    public HttpFutureCallout setTimeout(Integer timeout) {
        this.callout.Timeout = timeout;
        return this;
    }

    public void send() {
        HttpFutureCallout.sendHttpRequest(Json.serialize(this.callout));
    }

    // If we need to we can make this Apex queueable; then we can retry with backoff
    @future (callout=true)
    private static void sendHttpRequest(String calloutJson) {
        Callout calloutDefinition = (Callout)Json.deserialize(calloutJson, Callout.class);
        HttpRequest request = HttpFutureCallout.buildHttpRequest(calloutDefinition);
        HttpResponse response = new Http().send(request);
    }

    private static HttpRequest buildHttpRequest(Callout calloutDefinition) {
        HttpRequest request = new HttpRequest();
        request.setMethod(calloutDefinition.HttpMethod);
        request.setEndpoint(calloutDefinition.Endpoint);
        for(String headerName : calloutDefinition.Headers.keySet()) {
            request.setHeader(headerName, calloutDefinition.Headers.get(headerName));
        }
        if (calloutDefinition.Body != null) {
        	request.setBody(calloutDefinition.Body);
        }
        if (calloutDefinition.Timeout != null) {
            request.setTimeout(calloutDefinition.Timeout);
        }
        return request;
    }
    
    public class Callout {
        public String HttpMethod;
        public String Endpoint;
        public Map<String, String> Headers = new Map<String, String>();
        public String Body;
        public Integer Timeout;
    }
}