## Runtime Objects

Section could easily be combined with classes/oop/inheritance as this really refers to virtually anything other than an sObject.

### Apex Primative Types

Apex uses the same primitive data types as SOAP API, except for higher-precision Decimal type in certain cases. All primitive data types are passed by **value**.

All Apex variables, whether they’re class member variables or method variables, are initialized to null therefore you need to initialize them before use.

Apex primitive data types include:


| Data Type |	Description   |
|-----------|-----------------|
| Blob | A collection of binary data stored as a single object. You can convert this data type to String or from String using the toString and valueOf methods, respectively. Blobs can be accepted as Web service arguments, stored in a document (the body of a document is a Blob), or sent as attachments. |
| Boolean |	A value that can only be assigned true, false, or null.  | 
| Date | A value that indicates a particular day. Unlike Datetime values, Date values contain no information about time. Always create date values with a system static method. You can add or subtract an Integer value from a Date value, returning a Date value. Addition and subtraction of Integer values are the only arithmetic functions that work with Date values. You can’t perform arithmetic functions that include two or more Date values. Instead, use the Date methods. |
| Datetime | A value that indicates a particular day and time, such as a timestamp. Always create datetime values with a system static method.You can add or subtract an Integer or Double value from a Datetime value, returning a Date value. Addition and subtraction of Integer and Double values are the only arithmetic functions that work with Datetime values. You can’t perform arithmetic functions that include two or more Datetime values. Instead, use the Datetime methods. |
| Decimal | A number that includes a decimal point. Decimal is an arbitrary precision number. Currency fields are automatically assigned the type Decimal. |
| Double | A 64-bit number that includes a decimal point. Doubles have a minimum value of -263 and a maximum value of 263-1. Scientific notation (e) for Doubles is not supported. |
| ID | Any valid 18-character Lightning Platform record identifier. |
| Integer |	A 32-bit number that does not include a decimal point. Integers have a minimum value of -2,147,483,648 and a maximum value of 2,147,483,647. |
| Long | A 64-bit number that does not include a decimal point. Longs have a minimum value of -263 and a maximum value of 263-1. Use this data type when you need a range of values wider than the range provided by Integer. |
| Object | Any data type that is supported in Apex. Apex supports primitive data types (such as Integer), user-defined custom classes, the sObject generic type, or an sObject specific type (such as Account). All Apex data types inherit from Object. |
| String |Any set of characters surrounded by single quotes. |
| Time | A value that indicates a particular time. Always create time values with a system static method. |

### Object Metadata

Unfortunately there isn't a lot of metadata or reflection capabilities with objects although there are things we can do to make it look like the object is dynamic so that you can
- retrieve a property
- run a method

#### Retrieving a property
[DynamicObjectJSON.cls](DynamicObjectJSON.cls) show property access with a get method using JSON serialisation/de-serialisation
[DynamicObjectMap.cls](DynamicObjectMap.cls) show property access with a get method using a map of objects

#### Running a method
In Salesforce Winter '20 a new interface Callable was added. The Callable interface has a single method, the signature is `public Object call(String action, Map<String,Object> args)` and the way it works is that the caller passes an action (which could be the name of an actual method or something else) plus a set of key/value arguments (which could resemble parameter arguments). Example of using the Callable interface is in [DynamicMethodCall.cls](DynamicMethodCall.cls).

The Callable interface does not add anything new to the Salesforce developer experience, a user interface could have been added to do the same thing, what it does do is formalise the pattern which is of benefit to the community. However, using the Callable technique to invoke a method on another class has these drawbacks

 - Map key has not direct correlation with actual parameter names (could use p1, p2 as keys)
 - If expected Map key names are changed in the called class this could result in refactoring all of the calls into that class
 - - i.e. original value of a key was discountPrice but subsequently changed to discountPercentage
 - Called class needs to perform parameter presence and type checking
 - No inbuilt support for overloaded methods unless arity or parameters types are interrogated
 
 Given those limitations, is the map key (parameter name) important or would it have been easier/better to simply provide a generic list of objects in the Callable method signature?
 
### Other dynamic options

Salesforce introduced the Tooling API which I believe is used by the Salesforce CLI (sfdx) and can be used by the developer console.

Developers should use the Tooling API when they need fine-grained access to an org’s metadata. Tooling API’s SOQL capabilities for many metadata types allow you to retrieve smaller pieces of metadata. Smaller retrieves improve performance, which makes Tooling API a better fit for developing interactive applications.

The Tooling API comes with a rest resource making it easy to access all of the Tooling API objects, something to note is that the user permissions needed for access vary from endpoint to endpoint and from object to object. 

The Tooling API can also execute anonymous Apex, that is code you can generate on the fly, an example call is below.

```Apex
req.setEndpoint('http://instance.salesforce.com/services/data/v49.0/tooling/executeAnonymous/?
anonymousBody=System.debug('Test')%3B');
req.setMethod('GET');
```

However, this seems like quite an expensive and slow way to execute code.

The final option is ... not to use Salesforce at all, if you were considering the Tooling API why not write something outside of Salesforce in a language of your choice, without API limits, using caching mechanisms; you can view Salesforce as the central database store for your company or application. To facilitate shared data access Salesforce have Change Data Capture (cost involved) to assist in data synchronisation or you could roll your own equivalent. There are also Postgres to Salesforce data connectors, while not ideal they do allow for some flexibility in moving away from the Salesforce eco-system, of course you are still restricted by the API limits.

### Closing words
The Salesforce developer community has grown from its original user base and now includes seasoned developers coming from other languages. Most of the new wave of developers are used to performing some sort of interrogation of object instances as they are passed through code.

However, a language like Java or C# has a rich type system that is not easy to impliment in a custom language, other languages such as Python, JavaScript and Ruby are interpreted (or compiled to a rich type system in the case of JRuby) are interpreted so all of the Symbol tables are easily available.

Additionally when writing in a language most developers are concerned with only their application and not opening up the code to extensions. Having written frameworks that accept bespoke code I know the extension code should be untrusted, run in a seperate AppDomain (or clean room) and have restricted access to resources; the custom code should not take down your app or servers!

Given these arguments I can understand why Apex does not have more elements of reflection or dynamic invocation, if you have some imagination (like Callable) you could probably work around the limitations.
