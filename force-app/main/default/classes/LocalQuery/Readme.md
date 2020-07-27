LINQ like querying
-------------------

Those with a C# background have got used to the power and convenience of Language Integrated-Query (LINQ).

Language-Integrated Query (LINQ) is the name for a set of technologies based on the integration of query capabilities directly into the C# language. Traditionally, queries against data are expressed as simple strings without type checking at compile time or IntelliSense support. Furthermore, you have to learn a different query language for each type of data source: SQL databases, XML documents, various Web services, and so on. With LINQ, a query is a first-class language construct, just like classes, methods, events. You write queries against strongly typed collections of objects by using language keywords and familiar operators. The LINQ family of technologies provides a consistent query experience for objects (LINQ to Objects), relational databases (LINQ to SQL), and XML (LINQ to XML).

Java has no direct equivalent although for most Java streams represent an equivalent to LINQ, albeit in appearance only. Introduced in Java 8, the Stream API is used to process collections of objects. A stream is a sequence of objects that supports various methods which can be pipelined to produce the desired result.
The features of Java stream are –

- A stream is not a data structure instead it takes input from the Collections, Arrays or I/O channels.
- Streams don’t change the original data structure, they only provide the result as per the pipelined methods.
- Each intermediate operation is lazily executed and returns a stream as a result, hence various intermediate operations can be pipelined. Terminal operations mark the end of the stream and return the result.

Apex does not have any in built classes that can stream or map objects but it does come with a powerful object model and fantastic relational querying API in the form of Salesforce Object Querying Language (SOQL).

This exercise is all about taking the result of a SOQL query and then reducing or filtering the results.

[Basic Filtering](Basic/Readme.md)

[Composite Filtering](Composite/Readme.md)

[Predicate Filtering](BasicPredicate/Readme.md)

[String Expression Filtering](Expression/Readme.md)
