Custom REST API
--------------------

Creating a custom REST api in Salesforce is relatively easy and Salesforce can do a lot of haed work for you in binding/unbinding to complex objects

---EXAMPLE

If you are creating multiple endpoints there are a couple of things to note
- some implimentations use a global class per REST endpoint
- duplication of basic cross cutting concerns

The concept I decided to create here was inspired by middleware components like Ruby/RACK or ASP.Net/HttpModules. The middleware is to handle cross cutting concerns performing validation, routing and dispatching. 

With this design there is a single global CUSTOM REST endpoint to handle all incoming requests. The requests are handled by controllers that are registered with a dispatcher and called based on route matching. If the dispatcher finds a matching route the controllers execute method is called, if a route is not matched then the dispatcher automatically returns a 404.

My first implimentation used a pipeline to handle all cross cutting concerns, of which, the dispatcher was just one element. Each element in the pipeline adhered to an interface and was added to the pipeline using a registration process; the pipeline elements could run before the request was handled, afer the response had been created, on error only (i.e. exceptions thrown), always (irrespective of whethr an exception was thrown) or any combination.

For this demo I have embedded a "pipeline" by way of methods on a base controller using the [Template Method Pattern](https://en.wikipedia.org/wiki/Template_method_pattern). When invoked the base controller will call the following methods
- validatePermissions, to ensuring the user calling the API has the appropriate permissions
- validateHttpHeaders, to ensure the caller has specified the appropriate headers
- validateParameters, to ensure that the correct URL parameters have been set
Before calling the appropriate method which matches the requests http verb

Of course using a pipeline (or template method pattern) you can add extra elements to the process such as logging, sending telemetry etc.

## The demo code

There is a single [RestEndpoint](../src/demo-custom-rest-api/main/default/classes/Rest/RestEndpoint.cls) which creates an instance of the 
[RestDipatcher](../src/demo-custom-rest-api/main/default/classes/Rest/RestDispatcher.cls), if a route match is found a controller is called.

Adding new endpoints ought to be as easy as creating a new controller and registering it with the dispatcher.

[Example Account Controller](../src/demo-custom-rest-api/main/default/classes/Controllers/AccountsRestController.cls)
[Example Account By Id Controller](../src/demo-custom-rest-api/main/default/classes/Controllers/AccountIdRestController.cls)

Account Controller and Account By Id Controller can be consolidated into a single controller but for simplicity written as two controllers.

There is also an example postman collection.

