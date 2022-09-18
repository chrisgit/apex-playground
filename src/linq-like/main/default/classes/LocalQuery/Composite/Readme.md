Composite Filtering
-------------------

This is similar to C# Any and All LINQ functions and is used when you want to apply multiple filters, the results are based on
- ANY: true if an object matches ANY one of the filters match the criteria
- ALL: true is an object matches ALL filters match the criteria

Samples only show one filter condition applied per filter but multiple conditions could be included in a single filter but filters can be accumulated to simulate AND/OR conditions. 

Example below matches Accounts with Industry of technology that also have between 100 to 500 employees

```Apex
List<ICompositeAccountFilter> filters = new List<ICompositeAccountFilter> {
    new CompositeAccountSectorFilter('Technology'),
    new CompositeAccountEmployeeRangeFilter(100, 500)
};

List<Account> filteredAccounts = CompositeAccountRunner.selectWhenAllFiltersPass(accounts, filters);
```

Pros: 
- Keeps all looping logic in single locations
- Simple to implement
- As granular or as complex as you like
- Single loop with all filters applied

Cons:
- Is specific to the Salesforce type (i.e. Account, Contact or custom type)
- AND/OR conditions across filters are implied

To demonstrate the use of the predicate filters run the tests in [BasicCompositeTests.cls](BasicCompositeTests.cls)
