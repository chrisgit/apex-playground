Basic Filtering
---------------

The simplest type of filter is an inline filter which takes a list of objects and adds any matching items to a new list. 

This concept uses that principal but each filter is a separate class.

Samples here only show one filter condition applied per filter class but multiple conditions could be included in a filter class, depends on the use case.

The filters themselves could be cumulative and configured with a fluent interface.

Pros: 
- Keeps all looping logic in single locations
- Simple to implement
- As granular or as complex as you like

Cons:
- Iterates over loop each time filter is required
- Is specific to the Salesforce type (i.e. Account, Contact or custom type)

To demonstrate the use of the filter run the tests in [BasicAccountTests.cls](BasicAccountTests.cls)
