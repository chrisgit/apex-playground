Custom REST Api
--------------------

Create a custom REST api in Salesforce is relatively easy but there are a couple of things to note
- some implimentations use a global class per REST endpoint
- can be easy to forget or omit cross cutting concerns (such as ensuring headers are set or checking permissions)

The concept I decided to create here was inspired by middleware components like Ruby/RACK or ASP.Net/HttpModules that handle the request message to perform validation, routing and dispatching. 

With this design there is a single global endpoint to handle all incoming custom REST api requests. The requests are sent to controllers based on route matching. One of the core components is a dispatcher which matches the request path to a route whuch will be handled by a controller. If the dispatcher finds a matching route the controllers execute method is called, if a route is not matched then the dispatcher automatically returns a 404.

My first implimentation used a pipeline to handle all cross cutting concerns, of which, the dispatcher was just one element. Each element in the pipeline adhered to an interface and was added to the pipeline using a registration process; the pipeline elements could run before the request was handled, afer the response had been created, on error only (i.e. exceptions thrown), always (irrespective of whethr an exception was thrown) or any combination.

For this demo I have embedded a "pipeline" by way of methods on a base controller using the [Template Method Pattern](https://en.wikipedia.org/wiki/Template_method_pattern). When invoked the base controller will call the following methods
- validatePermissions, to ensuring the user calling the API has the appropriate permissions
- validateHttpHeaders, to ensure the caller has specified the appropriate headers
- validateParameters, to ensure that the correct URL parameters have been set
Before calling the appropriate method which matches the requests http verb

Of course using a pipeline (or template method pattern) you can add extra elements to the process such as logging, sending telemetry etc.

## The demo code
[Rest Endpoint](../src/demo-custom-rest-api/main/default/classes/Rest/RestEndpoint.cls)
[Dipatcher](../src/demo-custom-rest-api/main/default/classes/Rest/RestDispatcher.cls)
[Example Account Controller](../src/demo-custom-rest-api/main/default/classes/Controllers/AccountsRestController.cls)
[Example Account By Id Controller](../src/demo-custom-rest-api/main/default/classes/Controllers/AccountIdRestController.cls)

Account Controller and Account By Id Controller can be consolidated into a single controller but for simplicity written as two controllers.
There is also an example postman collection

