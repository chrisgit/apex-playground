@IsTest
public with sharing class BasicAccountTests {
    @IsTest
    public static void whenApplyingFilterToAccountList() {
        List<Account> accounts = AccountData.accounts();

        // Filter to extract technology accounts
        List<Account> filteredAccounts = new BasicAccountIndFilter('Technology').filter(accounts);

        System.Debug(filteredAccounts);
        System.assertEquals(6, filteredAccounts.size(), 'Basic Filter: Account data incorrectly filtered');
    }

    @IsTest
    public static void whenApplyingRangeFilterToAccountList() {
        List<Account> accounts = AccountData.accounts();

        // Apply further filter to only get accounts with > 1000 employees
        List<Account> filteredAccounts = new BasicAccountEmpRangeFilter(100, 500).filter(accounts);

        System.Debug(filteredAccounts);
        System.assertEquals(2, filteredAccounts.size(), 'Basic Filter: Account data RANGE incorrectly filtered');
    }

    @IsTest
    public static void whenApplyingMultipleFiltersToAccountList() {
        List<Account> accounts = AccountData.accounts();

        List<Account> technologyAccounts = new BasicAccountIndFilter('Technology').filter(accounts);
        List<Account> technologyAccountsOver100To500Employees = new BasicAccountEmpRangeFilter(100, 500).filter(technologyAccounts);

        System.Debug(technologyAccountsOver100To500Employees);
        System.assertEquals(1, technologyAccountsOver100To500Employees.size(), 'Basic Filter: Account data MULTIPLE incorrectly filtered');
    }

}
