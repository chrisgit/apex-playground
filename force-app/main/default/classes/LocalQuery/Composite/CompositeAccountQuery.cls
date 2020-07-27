public with sharing class CompositeAccountQuery {
    public static void example() {
        List<Account> accounts = AccountData.accounts();
        List<ICompositeAccountFilter> filters = new List<ICompositeAccountFilter> {
            new CompositeAccountSectorFilter('Technology'),
            new CompositeAccountEmployeeRangeFilter(100, 500)
        };

        List<Account> technologyAccountsWith100To500Employees = CompositeAccountRunner.selectWhenAllFiltersPass(accounts, filters);
        System.Debug(technologyAccountsWith100To500Employees);

        List<Account> technologyAccountsOr100To500Employees = CompositeAccountRunner.selectWhenAnyFiltersPass(accounts, filters);
        System.Debug(technologyAccountsOr100To500Employees);
    }
}
