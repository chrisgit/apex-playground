Future callout and Http Callout Helpers
---------------------------------------

The demo-http folder contains examples for 
- flexible future callout 
- http mock helper

## Flexible Future Callout
### HttpFutureCallout

From the Salesforce documentation
>Methods with the future annotation must be static methods, and can only return a void type. The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects or objects as arguments.

>The reason why sObjects can’t be passed as arguments to future methods is because the sObject might change between the time you call the method and the time it executes. In this case, the future method will get the old sObject values and might overwrite them. To work with sObjects that already exist in the database, pass the sObject ID instead (or collection of IDs) and use the ID to perform a query for the most up-to-date record. The following example shows how to do so with a list of IDs.

This has occasionally led to future methods that are tightly coupled to an implimentation or future methods that accept a lot of primate arguments. Presented here is a future callout class that can be assigned properties similar to the HttpRequest class but by way of a fluent interface such as

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

Out of the box Salesforce provide a HttpCalloutMock to capture the request details. Using HttpCalloutMock is reasonably simple although the examples on Salesforce are overly complex.

The MockHttpCalloutQueue aims to 
- simplify the setup of callout mock
- allow for stubbing of responses (no expectation)
- allow for mocking of responses (has an expectation)

The MockHttpCalloutQueue methods accept an HttpRequest and HttpResponse object, the class will match against as much or as little information that you provide in the HttpRequest object. For example if you want to set an expectation to a POST endpoint simply configure with
```
HttpRequest request = new HttpRequest();
request.setMethod('POST');
request.setEndpoint('https://test.com');
MockHttpCalloutQueue queue = new MockHttpCalloutQueue().expect(request, new HttpResponse());
Test.setMock(HttpCalloutMock.class, queue);
```

The expectation can be verified by calling the verifyExpectations method which returns a true or a false.
```
queue.verifyExpectations();
```

Stubbing is performed in a similar way but the setup uses the any method instead of the expect method. There is a caveat here though, any means that you can call the specified endpoint as multiple times, therefore if you want to ensure that your endpoint is called only once you should use expect.
```
HttpRequest request = new HttpRequest();
request.setMethod('GET');
request.setEndpoint('https://brewery.com/beers');
MockHttpCalloutQueue queue = new MockHttpCalloutQueue().any(request, httpCreated());
Test.setMock(HttpCalloutMock.class, queue);
```

Should you need to you can setup the MockHttpCalloutQueue to throw an exception based on an http call.




