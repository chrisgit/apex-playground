Unit Test Data Setup
--------------------

The [demo-test-data-builder](../src/demo-test-data-builder/main/default/classes/) folder contains examples for 
- name pointing data builder
- simple sObject wrapper data builder

### Background

When running unit tests there will be a time when you will need some sort of data setup. The Common types of test data for unit testing different scenarios maybe one of the following  
- Blank files or no data
- Valid set of test data
- Invalid set of test data
- Illegal format test data
- Test data to check boundary conditions, i.e. matches upper and lower boundaries
- Large test data for load, performance or stress testing
- Equivalence partition data
- Decision table data, for specific branches or conditions
- State transition data
- Use case data
- ... and so on

All bar blank files or no data require some data to be created! 

Salesforce has an excellent ORM where DML can be used inline with other code, this makes creating data simple but also means there is plenty of potentual to duplicate code, additionally parent/child data is created in a hierarchial format, i.e. create the parent objects, persiste, create the child records and assign them with the parent ids. Creating hierarchial test data using the ORM can lead to large setup methods, making the tests less expressive, harder to read, the intent of the test becomes unclear. At this point most development teams consider data patterns such as  [Object Mother](https://martinfowler.com/bliki/ObjectMother.html) and [Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern#:~:text=The%20builder%20pattern%20is%20a,Gang%20of%20Four%20design%20patterns.).

Note: for very large datasets you can load a CSV into your instance and retrive the data with [Test.loadData](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_load_data.htm) but for simpler tests you probably just want a few lines of setup.

### TestDataObject

The [TestDataObject](../src/demo-test-data-builder/main/default/classes/TestDataObject.cls) class is a base class that is used to wrap an sObject and store the sObjects parent relationships. The TestDataObject class needs to be inherited for each sObject that you want to simplify the data setup, the overloaded constructor requires the SObjectType and the concrete implimentation requires a reference to the underlying sObject. For example, code below wraps the standard Account object    
```Apex
public class WrappedAccount extends TestDataObject {
	private Account accountReference;

	public AccountTdo() {
		super(Account.SObjectType);
		accountReference = new Account();
	}
```

In the wrapped concrete class you will need to create methods for setting an getting the sObjects fields as well as the parent relationships.

Persisting the data is performed by the [TestDataRegistry](../src/demo-test-data-builder/main/default/classes/TestDataRegistry.cls) class; I wanted this class to closely resemble the Salesforce Database class.

By way of comparison [TestDataUsingSObjectsTests](../src/demo-test-data-builder/main/default/classes/TestDataUsingSObjectsTests.cls) test class demonstrates data setup using the out of the box Salesforce ORM to create Account/Opportunity/Contact, the parent records need to be inserted before the child records, for example
```Apex
Account account = new Account(Name = 'Test Account');
insert account;

Opportunity opportunity = new Opportunity(Name = 'Test Opportunity', CloseDate = Date.newInstance(2020, 1, 1), StageName = 'Open');
opportunity.AccountId = account.Id;

Contact contact = new Contact(FirstName = 'Unit', LastName = 'Test');
contact.AccountId = account.Id;

insert new List<SObject> { opportunity, contact };
```

The same tests have been replicated in [TestDataObjectTests](../src/demo-test-data-builder/main/default/classes/TestDataObjectTests.cls)
```Apex
OpportunityTdo opportunity = new OpportunityTdo();
ContactTdo contact = new ContactTdo();

TestDataRegistry.simpleInsert(new Set<TestDataObject> { new AccountTdo().contact(contact).opportunity(opportunity), contact, opportunity });
```

The TestDataRegistry simpleInsert method is written so that each sObject to be saved has to be added explicitly, the original implimentation implied parent/child relationships, meaning you only had to pass in a parent or child any relationships were traversed and sObjects automatically added to the unit of work;  simplifying data setup even further but making the persistance behavior less obvious.

Note: these classes perform much worse than the out of the box Salesforce ORM and will use more resources (i.e. heap space), therefore not suited for creating large datasets. For this demo, only insertion of data has been implimented, if you need to maintain data use the out of the box Salesforce ORM or extend the existing functionality.

### Creating relationships with name pointing

The second proof of concept is to set the parent/child relationships using [name pointing](https://salesforce.stackexchange.com/questions/133556/set-relationship-via-name-pointing-field). The idea being that instead of creating parent record, persisting the parent record in order to obtain an Id and assigning that Id to the child like so
```
Account acc = new Account(Name='Acme');
insert acc;
Opportunity opp = new Opportunity(AccountId=acc.Id); ...
insert opp;
```

The intention was to use the name pointing field (on an object without using an external reference) and provide a class to perform the persistance that resembles the [Database class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database.htm)

To demonstrate how name pointing can be used see the [NamepointingTests](../src/demo-test-data-builder/main/default/classes/NamepointingTests.cls) test class
```
Account acc = new Account(Name='Test Account');
Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=Date.newInstance(2022, 12, 1), StageName='Open', Account=acc);
Contact cnt = new Contact(FirstName = 'Unit', LastName = 'Test', Account=acc);

Namepointing.simpleInsert(new List<SObject> { acc, opp, cnt });
```

The result doesn't save many lines in the setup but could help to logically assign a field of an object to refer to a related object. Name pointing can also be modified to work with custom sObjects, for example
```Apex
Account acc = new Account(Name='Acme');
Opportunity opp = new Opportunity(Name='Acme Sales');
opp.Account = acc;
My_Custom_Object__c customObject = new My_Custom_Object__c();
customObject.Opportunity__r = opp;

Namepointing.simpleInsert(new List<SObject> { acc, opp, customObject });
```

Since creating the proof of concepts (and having implimented a variation at work) I have come across a [similar implementation](https://github.com/rsoesemann/apex-domainbuilder) by Robert Sösemann and have since added a cut down version of the [Apex Enterprise Library fflib unit of work](https://github.com/apex-enterprise-patterns/fflib-apex-common) to use the unit of work.
