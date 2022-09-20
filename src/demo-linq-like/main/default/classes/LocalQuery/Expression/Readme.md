String Expression Filtering
---------------------------

This is an over the top way of filtering data and uses a more natural language similar to a SQL statement.

The example below filters all Accounts with Industry of Technology and has less than 200 employees.

```Apex
List<Account> allAccounts = new List<Account> {
        new Account(Name = 'IBM', 	Industry = 'Services'),
        new Account(Name = 'Microsoft', Industry = 'Software'),
        new Account(Name = 'Oracle', Industry = 'Software')
};

List<Account> filteredAccounts = ExpressionQueryRunner.filterData(allAccounts, 'Account.Industry == "Technology" and Account.NumberOfEmployees < 200');
```

The filter is passed as a string and parsed.

The parser comes in two parts
- [Lexer](Lexer/Lexer.cls) to take the input string and convert it to tokens
- [Parser](Parser/Parser.cls) takes the tokens and in this case builds a filter statement using the [Basic Predicates](../BasicPredicate/Readme.md) described elsewhere

Pros: 
- Easier to read filter expressions

Cons:
- Difficult to impliment

To demonstrate the use of the string expression filters run the tests in [ExpressionQueryTests.cls](ExpressionQueryTests.cls)
