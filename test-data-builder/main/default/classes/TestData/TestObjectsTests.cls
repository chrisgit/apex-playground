@IsTest
public with sharing class TestObjectsTests {

    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        Account_to account = new Account_to();
        Opportunity_to opportunity = new Opportunity_to();
        Contact_to contact = new Contact_to();
        account.contact(contact).opportunity(opportunity);

        ObjectRegistry.simpleInsert(new Set<TestObject> { account, contact, opportunity });

        List<Account> accountList = getAccounts();
        List<Contact> contactList = getContacts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'CreateParentAddChild: number of accounts not correct');
        System.assertEquals(1, contactList.size(), 'CreateParentAddChild: number of contacts not correct');
        System.assertEquals(1, contactList.size(), 'CreateParentAddChild: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, contactList.get(0).AccountId, 'CreateParentAddChild: Contact not linked to account');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'CreateParentAddChild: Opportunity not linked to account');
    }

    @IsTest
    public static void whenCreateChildThenParentsAutomaticallyCreated() {
        Account_to account = new Account_to();
        Opportunity_to opportunity = new Opportunity_to().account(account);
        Contact_to contact = new Contact_to().account(account);

        ObjectRegistry.simpleInsert(new Set<TestObject> { account, opportunity, contact });

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();
        List<Contact> contactList = getContacts();

        System.assertEquals(1, accountList.size(), 'CreateChildCreateParent: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        System.assertEquals(1, contactList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, contactList.get(0).AccountId, 'CreateParentAddChild: Contact not linked to account');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'CreateChildCreateParent: Opportunity not linked to account');
    }

    @IsTest
    public static void whenCreatingSingleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfChildRecords = 100;
        Account_to account = new Account_to().name('Single Account');
        Set<TestObject> testObjects = new Set<TestObject> { account };
        for(Integer childCounter = 1; childCounter <= numberOfChildRecords; childCounter++) {
            testObjects.add(new Opportunity_to().name('Opportunity ' + childCounter).account(account));
        }

        ObjectRegistry.simpleInsert(testObjects);

        // Change this query to resemble the one in the other project
        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'CreateChildCreateParent: number of accounts not correct');
        System.assertEquals(numberOfChildRecords, opportunityList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        for(Integer childCounter = 0; childCounter < numberOfChildRecords; childCounter++) {
            System.assertEquals(accountList.get(0).Id, opportunityList.get(childCounter).AccountId, 'CreateChildCreateParent: Opportunity ' + childCounter + ' not linked to account');
        }
    }

    @IsTest
    public static void whenCreatingMultipleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfAccountRecords = 30;// 30;
        Integer numberOfOpportunityRecordsPerAccount = 10; // 10;
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

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();
        List<Contact> contactList = getContacts();

        Integer totalAccountRecords = numberOfAccountRecords;
        Integer totalOpportunityRecords = numberOfAccountRecords * numberOfOpportunityRecordsPerAccount;
        Integer totalContactRecords = numberOfAccountRecords * numberOfContactRecordsPerAccount;
        System.assertEquals(totalAccountRecords, accountList.size(), 'Number of accounts not correct');
        System.assertEquals(totalOpportunityRecords, opportunityList.size(), 'Number of opportunities not correct');
        System.assertEquals(totalContactRecords, contactList.size(), 'Number of contacts not correct');
    }

    private static List<Account> getAccounts() {
        return [SELECT Id, Name, AccountNumber, BillingAddress, ShippingAddress FROM Account];
    }

    private static List<Opportunity> getOpportunities() {
        return [SELECT Id, Name, AccountId, Description FROM Opportunity];
    }

    private static List<Contact> getContacts() {
        return [SELECT Id, AccountId, Description, MailingAddress FROM Contact];
    }
}
