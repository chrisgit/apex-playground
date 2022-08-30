public with sharing class BasicPredicateFilterLessThan extends BasePredicate {
    public BasicPredicateFilterLessThan(Schema.SObjectField field, Object matchValue) {
        super(field, matchValue);
    }

    public override Boolean evaluate(sObject obj) {
        Object fieldValue = obj.get(this.schemaField);
        Integer comparisonResult = ObjectInstance.compare(fieldValue, matchValue);
        return comparisonResult == -1;
    }
}
