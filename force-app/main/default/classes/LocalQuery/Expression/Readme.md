String Expression Filtering
---------------------------

Apex cannot easily execute dynamic code (although you can use the tooling API which is what SFDX uses) and does not directly support lamba functions. Reducing data AFTER SOQL is not recommended but as an exercise I wanted to see the different ways to do that.

String Expression Filtering is storing a filter statement in a string, parsing that string and executing the expression! This code uses the classes from the Basic Predicate example.

Pros: 
- Easier to read filter expressions

Cons:
- Difficult to impliment

To demonstrate the use of the string expression filters run the tests in [ExpressionQueryTests.cls](ExpressionQueryTests.cls)
