public class BasicPredicateFilterEqual extends BasePredicate {
    public BasicPredicateFilterEqual(Schema.SObjectField field, Object matchValue) {
        super(field, matchValue);
    }

    public override Boolean evaluate(sObject obj) {
        return obj.get(this.schemaField) == matchValue;
    }
}
