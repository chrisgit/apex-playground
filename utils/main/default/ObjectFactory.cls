// Wrap the Salesforce object metadata classes
public inherited sharing class ObjectFactory {
    private static Map<String, ObjectSchema> cachedSchema = new Map<String, ObjectSchema>();

    public static ObjectSchema getSchemaForSObject(String objectType) {
        if (cachedSchema.containsKey(objectType) == false) {
            Schema.DescribeSObjectResult sObjectResult = Schema.describeSObjects(new List<String> { objectType }).get(0);
            ObjectSchema schema = new ObjectSchema(sObjectResult);
            cachedSchema.put(objectType, schema);
        }
        return cachedSchema.get(objectType);
    }
}
