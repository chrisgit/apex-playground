@IsTest
public class TestDataUsingSObjectsTests {
    // SObject, for comparison against other types of builders in terms of code setup and execution time
    @IsTest
    public static void whenCreateParentAndAddChildThenObjectsLinked() {
        Account account = new Account(Name = 'Test Account');
        Opportunity opportunity = new Opportunity(Name = 'Test Opportunity', CloseDate = Date.newInstance(2020, 1, 1), StageName = 'Open');
        Contact contact = new Contact(FirstName = 'Unit', LastName = 'Test');
        insert account;
        opportunity.AccountId = account.Id;
        contact.AccountId = account.Id;
        insert new List<SObject> { opportunity, contact };

        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM Contacts) FROM Account];
        System.assertEquals(1, accounts.size(), 'Number of accounts not correct');
        for(Account ao: accounts) {
            System.assertEquals(1, ao.Opportunities.size(), 'Number of opportunities not correct');
            System.assertEquals(1, ao.Contacts.size(), 'Number of contacts not correct');
        }
    }


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
