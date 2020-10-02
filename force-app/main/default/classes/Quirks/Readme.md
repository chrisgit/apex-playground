Quirks
------

### Integer Division
Probably well known but this has tripped me up a few times, a division that involves an integers also returns integers - should be obvious but isn't always.

Given the following code

```Apex
System.Debug('division of integer by integer is ' + 50/100); // <=== Zero
System.Debug('division of decimal by integer is ' + 50.00/100); // <=== 0.50
System.Debug('division of integer by decimal is ' 50/100.00); // <=== 0.5
System.Debug('division of decimal by decimal is ' + 50.00/100.00); // <=== 0.5
System.Debug('division of integer by integer cast to decimal is ' + (Decimal) 50/100); // <=== 0.5
System.Debug('division of integer by integer result cast to decimal is ' + (Decimal) (99/2)); // <=== 49, calculation already performed, result is cast
System.Debug('division of integer by integer cast to double is ' + (Double) 99/2); // <=== 49.5
```

More examples are in [IntegerDivisionTests.cls](IntegerDivisionTests.cls) 

### Interfaces
An interface is a contact between your object and any consuming objects, it says that you object is guaranteed to implement the methods on the interface. If you codebase is only ever used internally you can change interfaces to your hearts content, if your code is shared or used externally you have to be careful not to change an interface as it will cause breaking changes.

The Apex language has the concept on an Interface but I find the implementation interesting. Interface methods normally relate to methods that will be on an instance of an object and not a static method (for a start I wouldn't even know how to convert a class with static methods to an interface without creating an instance and casting!). Apex allows you to impliment the interface as a static method, unsurprisingly you can call the method without instantiating the class but what is surprising is that you can instantiate the class, cast to the interface and call the method.

Example of this is shown with [QuirkyAddTests.cls](QuirkyAddTests.cls).
