// Respond with Payload plus Id's

@SuppressWarnings('PMD.FieldNamingConventions, PMD.MethodNamingConventions')
public inherited sharing class RestResponseWrapper {
    public String matchedUri {get; set;}

    // Perhaps make each one of these a class?
    // Therefore return new HttpResponse.NoContent() ... returns HttpResponseWrapper
    public RestResponseWrapper NoContent() {
        return StatusCode(204);
    }

    public RestResponseWrapper NotFound() {
        return StatusCode(404);
    }

    public RestResponseWrapper Ok() {
        return StatusCode(200);
    }

    public RestResponseWrapper Ok(Object body) {
        return StatusCodeAndResponse(200, body, false);
    }

    public RestResponseWrapper Created(Object body) {
        return StatusCodeAndResponse(201, body, false);
    }

    public RestResponseWrapper BadRequest() {
        return StatusCode(400);
    }

    public RestResponseWrapper Forbidden() {
        return StatusCode(403);
    }

    public RestResponseWrapper MethodNotAllowed(List<String> allowedMethods) {
        RestContext.response.addHeader('Allow', String.join(allowedMethods, ','));
        return StatusCode(405);
    }

    public RestResponseWrapper NotAcceptable() {
        return StatusCode(406);
    }

    public RestResponseWrapper UnsupportedMediaType(List<String> permittedContentTypes, String contentType) {
        return StatusCode(415);
    }

    public RestResponseWrapper InternalServerError() {
        return StatusCode(500);
    }

    public RestResponseWrapper StatusCodeAndResponse(Integer statusCode, Object body, Boolean suppressApexObjectNulls) {
        return StatusCode(statusCode).BodyAsJson(body, suppressApexObjectNulls);
    }

    public RestResponseWrapper StatusCode(Integer statusCode) {
        RestContext.response.statusCode = statusCode;
        return this;
    }

    public Integer StatusCode(){
        return RestContext.response.statusCode;
    }

    private RestResponseWrapper BodyAsJson(Object body, Boolean suppressApexObjectNulls) {
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(body, suppressApexObjectNulls));
        return this;
    }

    public RestResponseWrapper CustomRestException(CustomRestException ex) {
        return StatusCodeAndResponse(ex.getHttpStatusCode(),  new ErrorResponseDTO(ex), true);
    }
}
