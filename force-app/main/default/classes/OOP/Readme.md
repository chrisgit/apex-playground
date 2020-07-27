Apex Object Oriented Programming

According to [Salesforce] the Apex programming language is 
> Apex is a strongly typed, object-oriented programming language that allows developers to execute flow and transaction control statements on Salesforce servers in conjunction with calls to the API. Using syntax that looks like Java and acts like database stored procedures, Apex enables developers to add business logic to most system events, including button clicks, related record updates, and Visualforce pages. Apex code can be initiated by Web service requests and from triggers on objects.

Source: [https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_intro_what_is_apex.htm] 

Very little information can be found about the origins of the Apex language most believing it to be an early version of Java
> Apex syntax and semantics mimic Java, including:
> Variable and expression syntax
> Block and conditional syntax
> Loop syntax
> Object and array notation
> Pass by reference

Source: [https://developer.salesforce.com/page/A_Brief_Overview_of_the_Apex_Language]

In learning the Apex language we need to understand how it behaves when dealing with an object hierarchy, examples presented here create 
- OopAbstractBase (Abstract class)
-- OopField (inherited from Abstract class)
-- OopRelation (inherited from Abstract class)
- IOopBase (interface)
- VirtualBase (Virtual class)
-- VirtualField (inherited from Virtual class)
-- VirtualRelation (inherited from Virtual class)

The purpose of the tests to see how method overriding works along with how to up cast and down casting.

Abstract classes - cannot instantiate, must override.
Virtual classes - can instantiate and give default method behavior, overriding methods is optional.

Tests are [OopClassTests.cls](OopClassTests.cls)

Examples elaborate on the tests by storing instances of the classes in the base class to see how method dispatch is working; Apex works in the same way as Java and the expected way for an Object Orientated language of it's type, C# has a dynamic runtime library and has slightly different behavior. 

Examples are [OopClassExamples.cls](OopClassExamples.cls) run anonymous Apex with `OopClassExamples.showMethodOverloading();`.

[Salesforce]: https://www.salesforce.com/uk/
