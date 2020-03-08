// Wrap the Salesforce object metadata classes
public inherited sharing class ObjectFactory {
    protected Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe();

    public ObjectSchema getSchemaFor(String objectName) {
        Schema.SObjectType sObjectType = this.globalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult sObjectResult = sObjectType.getDescribe();
        return new ObjectSchema(sObjectResult);
    }
}
