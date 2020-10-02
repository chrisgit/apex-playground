@IsTest
public with sharing class TestObjectsTests {

    @IsTest
    public static void whenCreateParentAndAddChildThenObjectedLinked() {
        Account_to acc = Account_to.withDefaultValues()
            .contact(Contact_to.withDefaultValues());

        ObjectRegistry.persist();

        List<Account> accountList = getAccounts();
        List<Contact> contactList = getContacts();

        System.assertEquals(1, accountList.size(), 'CreateParentAddChild: number of accounts not correct');
        System.assertEquals(1, contactList.size(), 'CreateParentAddChild: number of contacts not correct');
        System.assertEquals(accountList.get(0).Id, contactList.get(0).AccountId, 'CreateParentAddChild: Contact not linked to account');
    }

    @IsTest
    public static void whenCreateChildThenParentsAutomaticallyCreated() {
        Opportunity_to opp = new Opportunity_to().name('Opp1').stage('Open').closes(2020, 08);

        ObjectRegistry.persist();

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'CreateChildCreateParent: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'CreateChildCreateParent: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'CreateChildCreateParent: Opportunity not linked to account');
    }

    @IsTest
    public static void whenChildIsReparentedThenLinkToNewParent() {
        Account_to acc = Account_to.withDefaultValues();
        Opportunity_to opp = new Opportunity_to().name('Opp1').stage('Open').closes(2020, 08);
        acc.opportunity(opp);

        ObjectRegistry.persist();

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'ChildIsReparented: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'ChildIsReparented: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'ChildIsReparented: Opportunity not linked to account');
    }

    @IsTest
    public static void whenChildIsCreatedParentInjectedThenChildLinksToParent() {
        Account_to acc = Account_to.withDefaultValues();
        Opportunity_to opp = new Opportunity_to(acc).name('Opp1').stage('Open').closes(2020, 08);

        ObjectRegistry.persist();

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();

        System.assertEquals(1, accountList.size(), 'ChildIsCreatedParentInjected: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'ChildIsCreatedParentInjected: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'ChildIsCreatedParentInjected: Opportunity not linked to account');
    }

    @IsTest
    public static void whenUsingFluentThenParentChildLinked() {
        new Account_to()
            .opportunity(new Opportunity_to().name('Opp1').stage('Open').closes(2020, 08))
            .contact(Contact_to.withDefaultValues());

        ObjectRegistry.persist();

        List<Account> accountList = getAccounts();
        List<Opportunity> opportunityList = getOpportunities();
        List<Contact> contactList = getContacts();

        System.assertEquals(1, accountList.size(), 'UsingFluent: number of accounts not correct');
        System.assertEquals(1, opportunityList.size(), 'UsingFluent: number of opportunities not correct');
        System.assertEquals(accountList.get(0).Id, opportunityList.get(0).AccountId, 'UsingFluent: Opportunity not linked to account');
        System.assertEquals(accountList.get(0).Id, contactList.get(0).AccountId, 'UsingFluent: Contact not linked to account');
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
