@IsTest
public with sharing class TestObjectsTests {

    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        Account_to account = new Account_to();
        Opportunity_to opportunity = new Opportunity_to();
        Contact_to contact = new Contact_to();
        account.contact(contact).opportunity(opportunity);

        ObjectRegistry.simpleInsert(new Set<TestObject> { account, contact, opportunity });

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(1, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(1, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    @IsTest
    public static void whenCreateChildThenParentsAutomaticallyCreated() {
        Account_to account = new Account_to();
        Opportunity_to opportunity = new Opportunity_to().account(account);
        Contact_to contact = new Contact_to().account(account);

        ObjectRegistry.simpleInsert(new Set<TestObject> { account, opportunity, contact });

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
        Account_to account = new Account_to().name('Single Account');
        Set<TestObject> testObjects = new Set<TestObject> { account };
        for(Integer childCounter = 1; childCounter <= numberOfChildRecords; childCounter++) {
            testObjects.add(new Opportunity_to().name('Opportunity ' + childCounter).account(account));
            testObjects.add(new Contact_to()
                            .first('Test ' + childCounter).last('Contact ' + childCounter)
                            .email(childCounter+'@'+childCounter+'.com').account(account));
        }

        ObjectRegistry.simpleInsert(testObjects);

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
        Set<TestObject> testObjects = new Set<TestObject>();
        for(Integer accountCounter = 1; accountCounter <= numberOfAccountRecords; accountCounter++) {
            Account_to account = new Account_to().name('Account ' + accountCounter);
            testObjects.add(account);
            for(Integer opportunityCounter = 1; opportunityCounter <= numberOfOpportunityRecordsPerAccount; opportunityCounter++) {
                testObjects.add(new Opportunity_to().name('Opportunity ' + opportunityCounter + ' for Acc ' + accountCounter).account(account));
            }
            for(Integer contactCounter = 1; contactCounter <= numberOfContactRecordsPerAccount; contactCounter++) {
                testObjects.add(new Contact_to()
                    .first('Contact ' + contactCounter).last('for Acc ' + accountCounter)
                    .email(accountCounter+'@'+contactCounter+'.com').account(account));
            }
        }

        ObjectRegistry.simpleInsert(testObjects);

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(numberOfAccountRecords, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfOpportunityRecordsPerAccount, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfContactRecordsPerAccount, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    // For comparison of code/setup and execution time
    @IsTest
    public static void whenCreatingMultipleParentMultipleChildrenUsingSObjectsThenParentAndChildrenCreated() {
        Integer numberOfAccountRecords = 30;
        Integer numberOfOpportunityRecordsPerAccount = 10;
        Integer numberOfContactRecordsPerAccount = 10;
        List<Account> accountsToInsert = new List<Account>();
        for(Integer accountCounter = 1; accountCounter <= numberOfAccountRecords; accountCounter++) {
            accountsToInsert.add(new Account(Name = 'Account'+ accountCounter));
        }
        insert accountsToInsert;

        // Cannot do Opportunity and Contact in a single loop and use List<SObject> due to chunking
        // ystem.TypeException: Cannot have more than 10 chunks in a single operation. Please rearrange the data to reduce chunking.
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        for(Account account : accountsToInsert) {
            for(Integer opportunityCounter = 1; opportunityCounter <= numberOfOpportunityRecordsPerAccount; opportunityCounter++) {
                // Have to add all mandatory fields
                opportunitiesToInsert.add(new Opportunity(Name = 'Opportunity ' + opportunityCounter + account.Name, AccountId = account.Id,
                                                        CloseDate = Date.newInstance(2020, 1, 1), StageName = 'Open'));
            }
        }
        insert opportunitiesToInsert;
        List<Contact> contactsToInsert = new List<Contact>();
        for(Account account : accountsToInsert) {
            for(Integer contactCounter = 1; contactCounter <= numberOfContactRecordsPerAccount; contactCounter++) {
                contactsToInsert.add(new Contact(FirstName = 'Contact ' + contactCounter, LastName = account.Name,
                    Email = contactCounter + '@' + account.Name + '.com', AccountId = account.Id));
            }
        }
        insert contactsToInsert;

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(numberOfAccountRecords, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfOpportunityRecordsPerAccount, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfContactRecordsPerAccount, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }
}
