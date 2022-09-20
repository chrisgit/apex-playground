@IsTest
public with sharing class ExpressionQueryTests {
    @IsTest
    public static void whenSimpleFilter() {
        List<Account> accounts = AccountData.accounts();

        List<Account> filteredAccounts = ExpressionQueryRunner.filterData(accounts, 'Account.Industry == "Technology"');
     
        System.Debug(filteredAccounts);
        System.assertEquals(6, filteredAccounts.size(), 'Expression: Account data EQUAL incorrectly filtered');
    }

    @IsTest
    public static void whenTwoFiltersJoinedWithAnd() {
        List<Account> accounts = AccountData.accounts();

        List<Account> filteredAccounts = ExpressionQueryRunner.filterData(accounts, 'Account.Industry == "Technology" and Account.NumberOfEmployees < 200');

        System.Debug(filteredAccounts);
        System.assertEquals(2, filteredAccounts.size(), 'Expression: Account data AND incorrectly filtered');
    }
    
    @IsTest
    public static void whenRangeFilter() {
        List<Account> accounts = AccountData.accounts();

        List<Account> filteredAccounts = ExpressionQueryRunner.filterData(accounts, 'Account.Industry == "Technology" and range(Account.NumberOfEmployees, 100, 200)');

        System.Debug(filteredAccounts);
        System.assertEquals(1, filteredAccounts.size(), 'Expression: Account data RANGE incorrectly filtered');
    }    
}
