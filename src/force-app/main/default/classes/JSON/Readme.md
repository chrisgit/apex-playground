JSON Capabilities and use
-------------------------

Automapper
----------
One of the criticisms aimed at the Apex programming language is that it lacks the ability to perform reflection on objects; that is interrogate objects to retrieve metadata that describes the objects appearance such as its type, fields and property names. As well as reading the metadata for an object reflection can usually write to the objects fields and properties or call static or instance methods. Reflection is normally associated with dynamic programming when we do not necessarily have the exact detail of an object (at compile time) but want to find out if it adheres to a certain shape or design.

Rather than use reflection we can work around the issue by using interfaces (for method calls) or property bags (for updating fields and properties) or simply deal with known data types that are available at compile time! Sometimes however, rather than repeat the same process over and over it is nice to have a generic method that will handle 80% of your scenarios.

One of the things that you may find yourself repeating is copying values from one object to another.

```
object1.prop1 = sObject.prop1;
object1.prop2 = sObject.prop2;
```

When repeating this process over and over you will want to write (a) code generator to create the mapping classes (b) generic class or method that will be capable of doing the map for you!

As a bit of fun I created the [Automapper](Automapper.cls)! 

The Automapper is designed to copy the result of a single SOQL record or SObject and map it to a DTO or any other kind of object. The Automapper accepts a field map of DTO fields and the corresponding SOBject fields, the field map is then used to extract the SObject values and place them into an Apex Hashmap which is then converted to the DTO using the JSON serialize methods. The process is akin to the old Scatter and Gather methods from the dBase era.

Some examples of the use are in the [Automapper Test class](AutomapperTests.cls)