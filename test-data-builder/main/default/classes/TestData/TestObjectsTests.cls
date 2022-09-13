@IsTest
public with sharing class TestObjectsTests {

    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        // Creating a parent and adding a child required both items to be persisted
        Account_to account = new Account_to();
        Opportunity_to opportunity = new Opportunity_to();
        Contact_to contact = new Contact_to();
        account.contact(contact).opportunity(opportunity);

        ObjectRegistry.persist(new Set<TestObject> { account, contact, opportunity });

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
        // Creating a child and adding a parent requires only child to be persisted (parent is automatically pulled in)
        // However it is better to add all objects
        ObjectRegistry.persist(new Set<TestObject> { new Opportunity_to().account(new Account_to()) });

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'CreateChildCreateParent: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'CreateChildCreateParent: Opportunity not linked to account');
    }

    // Do a join table test

    // Do some bulk tests
    @IsTest
    public static void whenCreatingSingleParentMultipleChildrenThenParentAndChildrenCreated() {
        Integer numberOfChildRecords = 100;
        Account_to account = new Account_to().name('Single Account');
        Set<TestObject> testObjects = new Set<TestObject> { account };
        for(Integer childCounter = 1; childCounter <= numberOfChildRecords; childCounter++) {
            testObjects.add(new Opportunity_to().name('Opportunity ' + childCounter).account(account));
        }

        ObjectRegistry.persist(testObjects);

        // Change this query to resemble the one in the other project
        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'CreateChildCreateParent: number of accounts not correct');
        System.assertEquals(numberOfChildRecords, opportunityList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        for(Integer childCounter = 0; childCounter < numberOfChildRecords; childCounter++) {
            System.assertEquals(accountList.get(0).Id, opportunityList.get(childCounter).AccountId, 'CreateChildCreateParent: Opportunity ' + childCounter + ' not linked to account');
        }
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
