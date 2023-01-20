public abstract inherited sharing class BaseController {
    public String controllerUri;
    public String controllerDomain;

    @SuppressWarnings('PMD.FieldNamingConventions')
    public RestRequestWrapper Request;
    @SuppressWarnings('PMD.FieldNamingConventions')
    public RestResponseWrapper Response;

    public BaseController(String controllerUri) {
        this.controllerUri = controllerUri;
    }

    public BaseController configure(RestRequestWrapper request, RestResponseWrapper response) {
        this.Request = request;
        this.Response = response;
        handleConfigure();
        return this;
    }

    public RestResponseWrapper execute() {
        Response.matchedUri = controllerDomain + controllerUri;

        if (validatePermissions() == false) {
            return Response.Forbidden();
        }
        if (validateHttpHeaders() == false) {
            return Response.NotAcceptable();
        }
        if (validateParameters() == false) {
            return Response.BadRequest();
        }

        try {
            return handleRequest();
        } catch (CustomRestException ex) {
            System.debug(LoggingLevel.ERROR, 'BaseController handled custom REST exception');
            System.debug(LoggingLevel.ERROR, ex);
            return Response.CustomRestException(ex);            
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 'BaseController handled exception');
            System.debug(LoggingLevel.ERROR, ex);
            return Response.CustomRestException(UnknownRestException.raise(ex));
        }
    }

    private RestResponseWrapper handleRequest() {
        
        switch on Request.requestType {
            when HTTPGET {
                return handleGet();
            }
            when HTTPPUT {
                return handlePut();
            }
            when HTTPPOST {
                return handlePost();
            }
            when HTTPDELETE {
                return handleDelete();
            }
            when HTTPPATCH {
                return handlePatch();
            }
        }
        return Response.InternalServerError();
    }

    public BaseController setControllerDomain(String domain) {
        this.controllerDomain = domain;
        return this;
    }

    // The template methods
    protected virtual List<String> getAllowedMethods() {
        return new List<String>{'GET'};
    }

    protected virtual RestResponseWrapper handleGet() {
        return Response.MethodNotAllowed(getAllowedMethods());
    }

    protected virtual RestResponseWrapper handlePost() {
        return Response.MethodNotAllowed(getAllowedMethods());
    }

    protected virtual RestResponseWrapper handlePut() {
        return Response.MethodNotAllowed(getAllowedMethods());
    }

    protected virtual RestResponseWrapper handleDelete() {
        return Response.MethodNotAllowed(getAllowedMethods());
    }

    protected virtual RestResponseWrapper handlePatch() {
        return Response.MethodNotAllowed(getAllowedMethods());
    }

    public String getUriMapping() {
        return controllerUri;
    }

    // Perhaps return an object or type that can be determined, i.e. if (HttpResponse then return Response etc)
    protected virtual Boolean validatePermissions() {
        return true;
    }

    protected virtual Boolean validateHttpHeaders() {
        return true;
    }

    protected virtual Boolean validateParameters() {
        return true;
    }

    protected virtual void handleConfigure() {
        return;
    }
}
