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

    public Boolean hasBody() {
        return string.isBlank(this.requestBody.toString()) ? false : true;
    }

    public Object deserialiseBody(System.Type apexType) {
        return JSON.deserialize(this.requestBody.toString(), apexType);

    }
}
