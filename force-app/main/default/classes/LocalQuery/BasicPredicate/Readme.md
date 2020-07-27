Predicate Filtering
--------------------

Predicate filtering is a step up from hard-coding classes with filters as it can provide some level of flexability but is more work to implement.

Personally I do not like predicates, their construction can be complex and they only offer limited capabilities. 

Pros: 
- More flexible filtering can be performed inline
- Simple to implement
- Single loop with all filters applied

Cons:
- Predicates are not the best way to declaratively represent logic or conditions
- Does consider complex queries that require functions, formulas or other identifiers
- - i.e. paid_date > invoice_date + 30

To demonstrate the use of the predicate filters run the tests in [BasicPredicateTests.cls](BasicPredicateTests.cls)
