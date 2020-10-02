Predicate Filtering
--------------------

Predicate filtering is a step up from hard-coding classes with filters as it can provide some level of flexability but is more work to implement.

In the predicate filtering examples here we have classes which represent filter expressions for Equal/Greater Than/Less Than/Range/Not as well as And/Or.

A simple predicate will carry out a single function although predicates can normally be accumulated to form complex statements.

The examples here allow the user to build up the predicates and then call a filterData method on a PredicateRunner class; the code below will match all Accounts with Industry of Technology that have less than 200 employees.

```Apex
BasicPredicateFilterAnd predicateTechnologyAnd1To100Employees = new BasicPredicateFilterAnd(
    new BasicPredicateFilterEqual(Account.Industry, 'Technology'),
    new BasicPredicateFilterLessThan(Account.NumberOfEmployees, 200)
);

List<Account> filteredAccounts = (List<Account>) BasicPredicateQueryRunner.filterData(accounts, predicateTechnologyAnd1To100Employees);
```

Personally I do not like predicates, their construction can be complex and they only offer limited capabilities. 

Pros: 
- More flexible filtering can be performed inline
- Simple to implement
- Single loop with all filters applied

Cons:
- Predicates are not the best way to declaratively represent logic or conditions
- Does consider complex queries that require functions, formulas or other identifiers
- - i.e. paid_date > invoice_date + 30

To demonstrate the use of the predicate filters run the tests in [BasicPredicateTests.cls](BasicPredicateTests.cls)
