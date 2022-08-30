@IsTest
public with sharing class BasicCompositeTests {
    @IsTest
    public static void whenAllFiltersPass() {
        List<Account> accounts = AccountData.accounts();
        // All Technology accounts with 100 to 500 employees
        List<ICompositeAccountFilter> filters = new List<ICompositeAccountFilter> {
            new CompositeAccountSectorFilter('Technology'),
            new CompositeAccountEmployeeRangeFilter(100, 500)
        };

        List<Account> filteredAccounts = CompositeAccountRunner.selectWhenAllFiltersPass(accounts, filters);

        System.Debug(filteredAccounts);
        System.assertEquals(1, filteredAccounts.size(), 'Composite: Account data ALL incorrectly filtered');
    }

    @IsTest
    public static void whenAnyFiltersPass() {
        List<Account> accounts = AccountData.accounts();
        // Technology accounts OR Accounts with 100 to 500 employees
        List<ICompositeAccountFilter> filters = new List<ICompositeAccountFilter> {
            new CompositeAccountSectorFilter('Technology'),
            new CompositeAccountEmployeeRangeFilter(100, 500)
        };

        List<Account> filteredAccounts = CompositeAccountRunner.selectWhenAnyFiltersPass(accounts, filters);

        System.Debug(filteredAccounts);
        System.assertEquals(7, filteredAccounts.size(), 'Composite: Account data ALL incorrectly filtered');
    }
}
