Basic Filtering
---------------

The simplest type of filter is an inline filter which takes a list of objects and adds any matching items to a new list.

```Apex
List<Account> allAccounts = new List<Account> {
        new Account(Name = 'IBM', 	Industry = 'Services'),
        new Account(Name = 'Microsoft', Industry = 'Software'),
        new Account(Name = 'Oracle', Industry = 'Software')
};
List<Account> softwareAccounts = new List<Account>();

for (Account account : accounts) {
    if (account.Industry == 'Software') {
        softwareAccounts.add(account);
    }
}
```

For maximum re-use each filter ought to be a separate method (possible partitioned by class, i.e. Accounts Filters) or separate class.

Samples here only show one filter condition applied per filter class but multiple conditions could be included in a filter class, depends on the use case.

```Apex
public List<Account> filterByIndustry(List<Account> accounts, String accountIndustry) {
    List<Account> accountsMatchIndustry = new List<Account>();

    for (Account account : accounts) {
        if (account.Industry == accountIndustry) {
            accountsMatchIndustry.add(account);
        }
    }

    return accountsMatchIndustry;
}
```

The filters themselves could be cumulative and configured with a fluent interface.

Pros: 
- Keeps all looping logic in single locations
- Simple to implement
- As granular or as complex as you like

Cons:
- Iterates over loop each time filter is required
- Is specific to the Salesforce type (i.e. Account, Contact or custom type)

To demonstrate the use of this type of filter run the tests in [BasicAccountTests.cls](BasicAccountTests.cls) which use
- [Range filter](BasicAccountEmpRangeFilter.cls)
- [Simple matching filter](BasicAccountIndFilter.cls)
