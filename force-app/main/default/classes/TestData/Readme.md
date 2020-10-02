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

The solution presented here is for creating unit test data that focuses on the most significant data; the most significant data is the data that you care about when you run the assertions on your unit tests. For example if you are using Salesforce Contact or Opportunity in your tests you do not want to obfuscate setup code with having to create multiple Accounts or push the data setup into obscure methods, the method here tries to keep the setup clean by automatically creating hierarchies.

The example here grew from a PoC using a [Fluent Interface](https://en.wikipedia.org/wiki/Fluent_interface) to configure test data - it originally combined use of an [Object Mother](https://martinfowler.com/bliki/ObjectMother.html) and [Builder Pattern](https://en.wikipedia.org/wiki/Builder_pattern#:~:text=The%20builder%20pattern%20is%20a,Gang%20of%20Four%20design%20patterns.).

Since creating the PoC I have come across a [similar implementation](https://github.com/rsoesemann/apex-domainbuilder) by Robert Sösemann and have since added a cut down version of the [Apex Enterprise Library fflib unit of work](https://github.com/apex-enterprise-patterns/fflib-apex-common) and created a variation of the graph to calculate the object dependencies.
