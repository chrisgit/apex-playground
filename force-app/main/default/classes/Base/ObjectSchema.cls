// Only expose what I want to expose
public inherited sharing class ObjectSchema {
    public String name
    {
        get {
            return this.objectResult.getName();
        }
    }

    protected Schema.DescribeSObjectResult objectResult;
    protected Map<String, Schema.SObjectField> objectFields;
    protected Map<String, Schema.FieldSet> objectFieldSets;

    public ObjectSchema(Schema.DescribeSObjectResult objectResult) {
        this.objectResult = objectResult;
        this.objectFields = objectResult.fields.getMap();
        this.objectFieldSets = objectResult.FieldSets.getMap();
    }

    public List<Schema.FieldSetMember> getFieldSet(String fieldSetName)
    {
        return this.objectFieldSets.get(fieldSetName).getFields();
    }

    public List<String> getFieldSetPathsOnly(String fieldSetName)
    {
        List<String> fieldPaths = new List<String>();

        for(Schema.FieldSetMember fieldSetMemberObj : this.getFieldSet(fieldSetName))
        {
            fieldPaths.Add(fieldSetMemberObj.getFieldPath());
        }

        return fieldPaths;
    }

    public Schema.SObjectField getField(String fieldName) {
        return objectFields.get(fieldName);
    }

    public DescribeFieldResult getFieldDescription(String fieldName) {
        Schema.SObjectField field = objectFields.get(fieldName);
        if (null == field) {
            return null;
        }
        return field.getDescribe();
    }
}

// getFieldDescription
// Schema.DescribeFieldResult a = Account.Name.getDescribe();
// Schema.DescribeFieldResult b = Schema.sObjectType.Account.fields.Name;
// Schema.DescribeFieldResult c = new ObjectSchema(Schema.sObjectType.Account).getFieldDescription('name'); 
// System.Debug(a);
// System.Debug(b);
// System.Debug(c);

// System.Debug('Compare objects  ...');
// System.Debug(a == b); // true
// System.Debug(a === b); // false

// System.Debug(a == c); // true
// System.Debug(a === c); // false

// System.Debug(b == c); // true
// System.Debug(b === c); // false
