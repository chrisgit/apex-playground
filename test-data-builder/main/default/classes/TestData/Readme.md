Unit Test Data Setup
--------------------

Common types of test data setup
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

All bar blank files or no data require some setup, normally test data is generated with scripts but the scripts are NOT always easy to read. Additionally data is created in a hierarchial format, i.e. create the top level objects constructed first then the children, children of children and so on.

Salesforce does have some additional options, if you have a large dataset for example you could load a CSV into your instance using [Test.loadData](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_load_data.htm) but for simpler tests you probably just want a few lines of setup.

The example here grew from a several proof of concepts. The first proof of concept used a [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) to configure test data - it originally combined use of an [Object Mother](https://martinfowler.com/bliki/ObjectMother.html) and [Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern#:~:text=The%20builder%20pattern%20is%20a,Gang%20of%20Four%20design%20patterns.). 

The second proof of concept was intended to pair back data setup and use SObjects but allow the setting of relationships using [name pointing](https://salesforce.stackexchange.com/questions/133556/set-relationship-via-name-pointing-field). The idea being that instead of creating parent record, persisting the parent record in order to obtain an Id and assigning that Id to the child like so
```
Account acc = new Account(Name='Acme');
insert acc;
Opportunity opp = new Opportunity(AccountId=acc.Id); ...
insert opp;
```

The intention was to use the name pointing field (on an object without using an external reference) and provide a class to perform the persistance that resembles the [Database class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_database.htm)
```
Account acc = new Account(Name='Acme');
Opportunity opp = new Opportunity();
opp.Account = opp;
TestData.insert(new List<SObject> { acc, opp });
```

The result doesn't save many lines in the setup but could help to logically assign a field of an object to refer to a related object.


Since creating the PoC I have come across a [similar implementation](https://github.com/rsoesemann/apex-domainbuilder) by Robert Sösemann and have since added a cut down version of the [Apex Enterprise Library fflib unit of work](https://github.com/apex-enterprise-patterns/fflib-apex-common) and created a variation of the graph to calculate the object dependencies.
