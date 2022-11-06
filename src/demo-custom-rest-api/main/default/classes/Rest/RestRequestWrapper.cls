public inherited sharing class RestRequestWrapper {
    public RequestType requestType;
    public String requestUri;
    public Blob requestBody;
    public Map<string, string> pathParameters;

    public RestRequestWrapper() {
        requestUri = RestContext.request.requestURI;
        requestBody = RestContext.request.requestBody;
    }

    public RestRequestWrapper setRequestType(RequestType type) {
        requestType = type;
        return this;
    }

    public RequestType getRequestType() {
        return this.requestType;
    }
}
