public abstract class BasePredicate {
    protected Object matchValue;
    protected Schema.SObjectField schemaField;

    // Default constructor
    public BasePredicate() {}

    public BasePredicate(Schema.SObjectField field, Object matchValue) {
        this.schemaField = field;
        this.matchValue = matchValue;
    }

    public abstract Boolean evaluate(sObject obj);
}