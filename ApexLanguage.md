From [Introduction to Apex]

### What is Apex?
Apex is a strongly typed, object-oriented programming language that allows developers to execute flow and transaction control statements on Salesforce servers in conjunction with calls to the API. Using syntax that looks like Java and acts like database stored procedures, Apex enables developers to add business logic to most system events, including button clicks, related record updates, and Visualforce pages. Apex code can be initiated by Web service requests and from triggers on objects.

As a language, Apex is:

### Integrated
Apex provides built-in support for common Lightning Platform idioms, including:
- Data manipulation language (DML) calls, such as INSERT, UPDATE, and DELETE, that include built-in DmlException handling
- Inline Salesforce Object Query Language (SOQL) and Salesforce Object Search Language (SOSL) queries that return lists of sObject records
- Looping that allows for bulk processing of multiple records at a time
- Locking syntax that prevents record update conflicts
- Custom public API calls that can be built from stored Apex methods
- Warnings and errors issued when a user tries to edit or delete a custom object or field that is referenced by Apex

### Easy to use
Apex is based on familiar Java idioms, such as variable and expression syntax, block and conditional statement syntax, loop syntax, object and array notation. Where Apex introduces new elements, it uses syntax and semantics that are easy to understand and encourage efficient use of the Lightning Platform. Therefore, Apex produces code that is both succinct and easy to write.

### Data focused
Apex is designed to thread together multiple query and DML statements into a single unit of work on the Salesforce server. Developers use database stored procedures to thread together multiple transaction statements on a database server in a similar way. Like other database stored procedures, Apex does not attempt to provide general support for rendering elements in the user interface.

### Rigorous
Apex is a strongly typed language that uses direct references to schema objects such as object and field names. It fails quickly at compile time if any references are invalid. It stores all custom field, object, and class dependencies in metadata to ensure that they are not deleted while required by active Apex code.

### Hosted
Apex is interpreted, executed, and controlled entirely by the Lightning Platform.

### Multitenant aware
Like the rest of the Lightning Platform, Apex runs in a multitenant environment. So, the Apex runtime engine is designed to guard closely against runaway code, preventing it from monopolizing shared resources. Any code that violates limits fails with easy-to-understand error messages.

### Easy to test
Apex provides built-in support for unit test creation and execution. It includes test results that indicate how much code is covered, and which parts of your code could be more efficient. Salesforce ensures that all custom Apex code works as expected by executing all unit tests prior to any platform upgrades.

### Versioned
You can save your Apex code against different versions of the API. This enables you to maintain behavior.

From [Brief overview of Apex]

The Apex language is a procedural extension to the Force.com API that allows flow control and transaction control to be executed on the server in conjunction with these basic database API calls, both SOQL and DML. The language's motivation is very similar to Oracle's PL/SQL — namely to thread together multiple SOQL and DML statements as a single unit of work on the server. The result is a platform that allows much more performant applications, and a new range of options for application developers.

### Apex Syntax and Semantics
Apex syntax and semantics mimic Java, including:

- Variable and expression syntax
- Block and conditional syntax
- Loop syntax
- Object and array notation
- Pass by reference

Where Apex uses embedded AppExchange-specific concepts, the syntax and semantics are easy to understand and encourage efficient use of the API.

The Apex language is strongly typed with direct (non-quoted) references to object and field names, both standard and custom. This is the primary motivation for a new language and runtime; we have full control over the syntax and the ability to reference dynamic schema elements. Writing our own parser and runtime model also allows us to handle AppExchange API-specific concepts such as query and queryMore cursors and other common idioms.

### Apex Runtime
Apex scripts can include anonymous blocks to be executed on-the-fly as well as stored packages and triggers. They are parsed into an abstract syntax tree (ANTLR, ANother Tool for Language Recognition, is the basis of the parser) and the resulting compiled form is then executed at runtime like any other procedural logic on the AppExchange server.

The compiled classes are represented in the AppExchange Java application server like other utility classes, such as the ones that already exist to represent SOQL queries. Many of these Apex classes sit on top of existing AppExchange API data structures and classes. When a script is parsed and executed, it runs with a context user, just as any other request or batch-process runs in the application. In this way the Apex runtime should be seen as just another piece of the normal AppExchange application server, but one that has additional rules and governors to prevent infinite loops.

[Introduction to Apex]: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_intro_what_is_apex.htm "Introduction to Apex from Salesforce"
[Brief overview of Apex]: https://developer.salesforce.com/page/A_Brief_Overview_of_the_Apex_Language "Brief overview of Apex from Salesforce"
