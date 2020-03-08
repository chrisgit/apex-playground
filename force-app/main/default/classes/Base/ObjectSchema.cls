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

    public DescribeFieldResult getField(String fieldName) {
        return objectFields.get(fieldName).getDescribe();
    }
}
