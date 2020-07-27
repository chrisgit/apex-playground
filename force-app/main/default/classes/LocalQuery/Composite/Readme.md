Composite Filtering
-------------------

This is similar to Ruby or Java or C# functions when you want to apply multiple filters and return records where
- object is selected is ANY one of the filters match the criteria
- object is selected when ALL filters match the criteria

Samples only show one filter condition applied per filter but multiple conditions could be included in a single filter but filters can be accumulated to simulate AND/OR conditions. 

Pros: 
- Keeps all looping logic in single locations
- Simple to implement
- As granular or as complex as you like
- Single loop with all filters applied

Cons:
- Is specific to the Salesforce type (i.e. Account, Contact or custom type)
- AND/OR conditions across filters are implied

To demonstrate the use of the predicate filters run the tests in [BasicCompositeTests.cls](BasicCompositeTests.cls)
