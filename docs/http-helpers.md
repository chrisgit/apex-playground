Future callout and Http Callout Helpers
---------------------------------------

The [demo-http](../src/demo-http/main/default/classes/) folder contains examples for 
- flexible future callout class
- http callout mock helper

## Flexible Future Callout
### HttpFutureCallout

Is a class that wraps the @future(callout=true) annotation to simplify making callouts. Using the out of the box functionality has the following limitations

From the [Salesforce developer documentation](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_invoking_future_methods.htm)
>Methods with the future annotation must be static methods, and can only return a void type. The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects or objects as arguments.

This has occasionally led to future methods that are tightly coupled to an implimentation or future methods that accept a lot of primative arguments. Each new value to be sent across the wire needs to be passed in to the callout method

```Apex
global class FutureMethodExample
{
    @future(callout=true)
    public static void patchExternalSystem(String valueA, Integer valueB)
    {   
         // Perform a callout to an external service
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_PATCH);
    }

}
```

If the values to be sent across the wire come from sObjects then Salesforce recommends passing in the object id(s) of the sObjects because

>The reason why sObjects can’t be passed as arguments to future methods is because the sObject might change between the time you call the method and the time it executes. In this case, the future method will get the old sObject values and might overwrite them. To work with sObjects that already exist in the database, pass the sObject ID instead (or collection of IDs) and use the ID to perform a query for the most up-to-date record. The following example shows how to do so with a list of IDs.

The [HttpFutureCallout](../src/demo-http/main/default/classes/HttpFutureCallout.cls) class presented here is a http callout marked with @future annotation that can be assigned properties similar to the HttpRequest class; it can also use objects instead of primative values because the request is serialised and sent to the callout as a large string.

The class uses fluent api, the request to the future method is called when the send method on the class is called.

```
new HttpFutureCallout()
    .setMethod(REQUEST_METHOD)
    .setEndpoint(REQUEST_ENDPOINT)
    .setHeader(HEADER_CONTENT_TYPE_NAME, HEADER_CONTENT_TYPE_VALUE)
    .setBody(REQUEST_BODY)
    .send();
```

## Flexible Http Test Mocking
### MockHttpCalloutQueue

In a Salesforce unit test you cannot make an http call to a service but you can capture an http request and inspect the values that would be sent across the wire with an http mock.

Out of the box Salesforce provide a HttpCalloutMock to capture the request details. Using HttpCalloutMock is reasonably simple although the examples on [Salesforce developer](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_restful_http_testing_httpcalloutmock.htm)are overly complex.

The [MockHttpCalloutQueue](../src/demo-http/main/default/classes/MockHttpCalloutQueue.cls) class aims to 
- simplify the setup of callout mock
- allow for stubbing of responses (no expectation)
- allow for mocking of responses (has an expectation)

The MockHttpCalloutQueue methods accept out of the box Salesforce HttpRequest and HttpResponse objects, the class will match against as much or as little information that you provide in the HttpRequest object. 

Setting an expectation is done by calling the expect method on the class, below will expect a POST to https://test.com
```
# Out of the box Salesforce HttpRequest used to set expectation
HttpRequest expectedRequest = new HttpRequest();
expectedRequest.setMethod('POST');
expectedRequest.setEndpoint('https://test.com');
HttpResponse responseFromExpected = new HttpResponse();

MockHttpCalloutQueue queue = new MockHttpCalloutQueue().expect(request, responseFromExpected);
Test.setMock(HttpCalloutMock.class, queue);
```

The expectation can be verified by calling the verifyExpectations method which returns a true or a false.
```
queue.verifyExpectations();
```

Stubbing is performed in a similar way but the setup uses the any method instead of the expect method. There is a caveat here though, any means that you can call the specified endpoint multiple times, therefore if you want to ensure that your endpoint is called only once you should use expect.
```
HttpRequest request = new HttpRequest();
request.setMethod('GET');
request.setEndpoint('https://brewery.com/beers');
MockHttpCalloutQueue queue = new MockHttpCalloutQueue().any(request, httpCreated());
Test.setMock(HttpCalloutMock.class, queue);
```

As usual, these are just skeleton classes, there are plenty of extension points to modify and enhance the functionalty.

## Example
### AddressChangeEventTriggerHandlerTest

The [AddressChangeEventTriggerHandlerTest](../src/demo-http/main/default/classes/AddressChangeEventTriggerHandlerTest.cls) class tests the HttpFutureCallout class and makes use of the MockHttpCalloutQueue class to set any callout expectations.

The AddressChangeEventTriggerHandlerTest tests simulate a change of an address platform event trigger handler that makes a call to a third party API.


