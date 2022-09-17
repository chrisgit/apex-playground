@IsTest
public with sharing class TestDataObjectTests {

    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        AccountTdo account = new AccountTdo();
        OpportunityTdo opportunity = new OpportunityTdo();
        ContactTdo contact = new ContactTdo();
        account.contact(contact).opportunity(opportunity);

        TestDataRegistry.simpleInsert(new Set<TestDataObject> { account, contact, opportunity });

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(1, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(1, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    @IsTest
    public static void whenCreateChildThenParentsAutomaticallyCreated() {
        AccountTdo account = new AccountTdo();
        OpportunityTdo opportunity = new OpportunityTdo().account(account);
        ContactTdo contact = new ContactTdo().account(account);

        TestDataRegistry.simpleInsert(new Set<TestDataObject> { account, opportunity, contact });

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(1, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(1, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    @IsTest
    public static void whenCreatingSingleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfChildRecords = 100;
        AccountTdo account = new AccountTdo().name('Single Account');
        Set<TestDataObject> testObjects = new Set<TestDataObject> { account };
        for(Integer childCounter = 1; childCounter <= numberOfChildRecords; childCounter++) {
            testObjects.add(new OpportunityTdo().name('Opportunity ' + childCounter).account(account));
            testObjects.add(new ContactTdo()
                            .first('Test ' + childCounter).last('Contact ' + childCounter)
                            .email(childCounter+'@'+childCounter+'.com').account(account));
        }

        TestDataRegistry.simpleInsert(testObjects);

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfChildRecords, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfChildRecords, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    // Note: When you have the Developer Console open these "bulk" tests run very slowly due to SF writing to the log
    @IsTest
    public static void whenCreatingMultipleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfAccountRecords = 30;
        Integer numberOfOpportunityRecordsPerAccount = 10;
        Integer numberOfContactRecordsPerAccount = 10;
        Set<TestDataObject> testObjects = new Set<TestDataObject>();
        for(Integer accountCounter = 1; accountCounter <= numberOfAccountRecords; accountCounter++) {
            AccountTdo account = new AccountTdo().name('Account ' + accountCounter);
            testObjects.add(account);
            for(Integer opportunityCounter = 1; opportunityCounter <= numberOfOpportunityRecordsPerAccount; opportunityCounter++) {
                testObjects.add(new OpportunityTdo().name('Opportunity ' + opportunityCounter + ' for Acc ' + accountCounter).account(account));
            }
            for(Integer contactCounter = 1; contactCounter <= numberOfContactRecordsPerAccount; contactCounter++) {
                testObjects.add(new ContactTdo()
                    .first('Contact ' + contactCounter).last('for Acc ' + accountCounter)
                    .email(accountCounter+'@'+contactCounter+'.com').account(account));
            }
        }

        TestDataRegistry.simpleInsert(testObjects);

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(numberOfAccountRecords, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfOpportunityRecordsPerAccount, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfContactRecordsPerAccount, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }
}
