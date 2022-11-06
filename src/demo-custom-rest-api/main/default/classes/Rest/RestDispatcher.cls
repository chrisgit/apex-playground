public inherited sharing class RestDispatcher {
    private static final string PATH_SEPARATOR = '/';
    private static final string PARAMETER_DELIMETERS = '{}';

    List<BaseController> registeredControllers = new List<BaseController>();

    public RestDispatcher register(BaseController controller) {
        System.debug(LoggingLevel.DEBUG, string.format('RestDispatcher: register controller [{0}] as [{1}]', new object[] { controller.getUriMapping(), controller }));
        registeredControllers.add(controller);
        return this;
    }

    public RestResponseWrapper execute(RestRequestWrapper request, RestResponseWrapper response) {
        System.debug(LoggingLevel.DEBUG, string.format('Attempting to dispatch [{0}] [{1}]', new Object[] { request.RequestType, request.requestURI}));
        for (BaseController controller : registeredControllers) {
            System.debug(LoggingLevel.DEBUG, string.format('Checking controller [{0}]', new Object[] { controller }));
            if (matchRoute(request, controller.getUriMapping())) {
                System.debug(LoggingLevel.DEBUG, string.format('Matched request against controller [{0}]', new Object[] { controller }));

                return controller
                    .configure(request, response)
                    .execute();
            }
        }
        System.debug(LoggingLevel.DEBUG, 'No matching controller found for the request path, returning 404');
        return response.NotFound();
    }

    private Boolean matchRoute(RestRequestWrapper request, String controllerRoute) {
        List<String> requestUriElements = request.requestUri.split(PATH_SEPARATOR);
        List<String> controllerRouteElements = controllerRoute.split(PATH_SEPARATOR);
        if (requestUriElements.size() != controllerRouteElements.size()) {
            return false;            
        }
        Map<string, string> pathParameters = new Map<string, string>();
        for (Integer i = 0; i < controllerRouteElements.size(); i++) {
            if (pathElementIsVariable(controllerRouteElements.get(i))) {
                pathParameters.put(stripVariableDelimeters(controllerRouteElements.get(i)), requestUriElements.get(i));
            } else if (controllerRouteElements.get(i) != requestUriElements.get(i)) {
                return false;
            }
        }

        request.pathParameters = pathParameters;
        return true;
    }

    private Boolean pathElementIsVariable(string pathElement) {
        System.Debug(pathElement);
        return pathElement.startsWith('{') && pathElement.endsWith('}');
    }

    private string stripVariableDelimeters(string pathElement) {
        return pathElement.mid(1, pathElement.length() - 2); // .removeStart('{') then .removeEnd('}')
    }
}
