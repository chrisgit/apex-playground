@RestResource(UrlMapping = '/*')
global inherited sharing class RestEndpoint {
    private static RestDispatcher dispatcher = new RestDispatcher();

    static
    {
        dispatcher.register(new AccountsRestController('/accounts'));
        dispatcher.register(new AccountIdRestController('/accounts/{id}'));
    }

    @HttpGet
    global static void doGET() {
        execute(RequestType.HTTPGET);
    }

    @HttpPost
    global static void doPOST() {
        execute(RequestType.HTTPPOST);
    }

    @HttpPut
    global static void doPUT() {
        execute(RequestType.HTTPPUT);
    }

    @HttpPatch
    global static void doPATCH() {
        execute(RequestType.HTTPPATCH);
    }

    @HttpDELETE
    global static void doDELETE() {
        execute(RequestType.HTTPDELETE);
    }

    private static void execute(RequestType requestType) {
        dispatcher.execute(new RestRequestWrapper().setRequestType(requestType), new RestResponseWrapper());
    }
}
