@IsTest
public with sharing class BasicPredicateTests {
    @IsTest
    public static void whenSimpleFilter() {
        List<Account> accounts = AccountData.accounts();
        BasicPredicateFilterEqual predicateTechnologyAccounts = new BasicPredicateFilterEqual(Account.Industry, 'Technology');

        List<Account> filteredAccounts = (List<Account>) BasicPredicateQueryRunner.filterData(accounts, predicateTechnologyAccounts);

        System.Debug(filteredAccounts);
        System.assertEquals(6, filteredAccounts.size(), 'Predicate: Account data EQUAL incorrectly filtered');
    }

    @IsTest
    public static void whenTwoFiltersJoinedWithAndCondition() {
        List<Account> accounts = AccountData.accounts();
        BasicPredicateFilterAnd predicateTechnologyAnd1To100Employees = new BasicPredicateFilterAnd(
            new BasicPredicateFilterEqual(Account.Industry, 'Technology'),
            new BasicPredicateFilterLessThan(Account.NumberOfEmployees, 200)
        );

        List<Account> filteredAccounts = (List<Account>) BasicPredicateQueryRunner.filterData(accounts, predicateTechnologyAnd1To100Employees);
        
        System.Debug(filteredAccounts);
        System.assertEquals(2, filteredAccounts.size(), 'Predicate: Account data AND incorrectly filtered');
    }
    
    @IsTest
    public static void whenRangeFilter() {
        List<Account> accounts = AccountData.accounts();
        BasicPredicateFilterAnd predicateTechnologyAnd1To100Employees = new BasicPredicateFilterAnd(
            new BasicPredicateFilterEqual(Account.Industry, 'Technology'),
            new BasicPredicateFilterRange(Account.NumberOfEmployees, 100, 200)
        );

        List<Account> filteredAccounts = (List<Account>) BasicPredicateQueryRunner.filterData(accounts, predicateTechnologyAnd1To100Employees);
        
        System.Debug(filteredAccounts);
        System.assertEquals(1, filteredAccounts.size(), 'Predicate: Account data RANGE incorrectly filtered');
    }

    @IsTest
    public static void whenFilterUsingNot() {
        List<Account> accounts = AccountData.accounts();
        BasicPredicateFilterEqual predicateTechnologyAccounts = new BasicPredicateFilterEqual(Account.Industry, 'Technology');
        BasicPredicateFilterNot predicateNot = new BasicPredicateFilterNot(predicateTechnologyAccounts);

        List<Account> filteredAccounts = (List<Account>) BasicPredicateQueryRunner.filterData(accounts, predicateNot);

        System.Debug(filteredAccounts);
        System.assertEquals(10, filteredAccounts.size(), 'Predicate: Account data NOT incorrectly filtered');
    }
}
