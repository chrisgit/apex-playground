@IsTest
public class NamepointingTests {
    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        Account acc = new Account(Name='Test Account');
        Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=Date.newInstance(2022, 12, 1), StageName='Open', Account=acc);
        Contact cnt = new Contact(FirstName = 'Unit', LastName = 'Test', Account=acc);

        Namepointing.simpleInsert(new List<SObject> { acc, opp, cnt });

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(1, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(1, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    @IsTest
    public static void whenOnlyChildrenInsertedThenParentObjectAddedAndLinked() {
        Account acc = new Account(Name='Test Account');
        Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=Date.newInstance(2022, 12, 1), 
            StageName='Open', Account = acc);
        Contact cnt = new Contact(FirstName = 'Unit', LastName = 'Test', Account = acc);

        Namepointing.simpleInsert(new List<SObject> { opp, cnt });

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
        Account acc = new Account(Name='Single Account');
        List<SObject> objectsToInsert = new List<SObject> { acc };
        for(Integer childCounter = 1; childCounter <= numberOfChildRecords; childCounter++) {
            objectsToInsert.add(new Opportunity(Name='Test Opportunity ' + childCounter, CloseDate=Date.newInstance(2022, 12, 1), 
                                StageName='Open', Account = acc));
            objectsToInsert.add(new Contact(FirstName = 'Unit ' + childCounter, LastName = 'Test ' + childCounter, Account = acc));
        }

        Namepointing.simpleInsert(objectsToInsert);

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfChildRecords, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfChildRecords, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

    @IsTest
    public static void whenCreatingMultipleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfAccountRecords = 30;
        Integer numberOfOpportunityRecordsPerAccount = 10;
        Integer numberOfContactRecordsPerAccount = 10;
        List<SObject> objectsToInsert = new List<SObject>();
        for(Integer accountCounter = 1; accountCounter <= numberOfAccountRecords; accountCounter++) {
            Account acc = new Account(Name='Multiple Account ' + accountCounter);
            objectsToInsert.add(acc);
            for(Integer opportunityCounter = 1; opportunityCounter <= numberOfOpportunityRecordsPerAccount; opportunityCounter++) {
                objectsToInsert.add(new Opportunity(Name='Opportunity ' + opportunityCounter + ' for Acc ' + accountCounter, 
                                    CloseDate=Date.newInstance(2022, 12, 1), StageName='Open', Account = acc));
            }
            for(Integer contactCounter = 1; contactCounter <= numberOfContactRecordsPerAccount; contactCounter++) {
                objectsToInsert.add(new Contact(FirstName = 'Contact ' + contactCounter, LastName = 'for Acc ' + accountCounter, Account = acc));
            }
        }

        Namepointing.simpleInsert(objectsToInsert);

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(numberOfAccountRecords, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(numberOfOpportunityRecordsPerAccount, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(numberOfContactRecordsPerAccount, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }

}
