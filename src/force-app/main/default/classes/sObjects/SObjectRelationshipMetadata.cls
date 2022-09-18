public with sharing class SObjectRelationshipMetadata {
    public static void runExamples() {
        // DynamicSObject.objectRelationships();
        SObjectRelationshipMetadata.objectRelationshipsUsingObjectType(Account.SObjectType);
        SObjectRelationshipMetadata.objectRelationshipsUsingSchemaGlobalDescribe('Account');
        SObjectRelationshipMetadata.childRelationships(Account.SObjectType);
        SObjectRelationshipMetadata.fieldRelationships(Account.SObjectType);
    }

    public static void objectRelationshipsUsingObjectType(Schema.SObjectType objectType) {
        StaticLogger.debug('************* Object relationships using object type');
        for(Schema.SobjectField field: objectType.getDescribe().fields.getMap().Values())
        {
            DescribeFieldResult fieldDescriptor = field.getDescribe();
            if(fieldDescriptor.getType() == Schema.DisplayType.REFERENCE)
            {
                StaticLogger.debug('====parent object===={0}=={1}', fieldDescriptor.getName(), fieldDescriptor.getReferenceTo());
            } 
        }
    }

    public static void objectRelationshipsUsingSchemaGlobalDescribe(String objectName) {
        StaticLogger.debug('************* Object relationships using global describe');

        Map<String, Schema.SObjectType> globalSchemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType accountSchema = globalSchemaMap.get(objectName);
        Map<String, Schema.SObjectField> fieldMap = accountSchema.getDescribe().fields.getMap();

        // Get all the field labels for Account Object where type is reference
        for (String fieldName: fieldMap.keySet()) {
            DescribeFieldResult fieldDescriptor = fieldMap.get(fieldName).getDescribe();
            Schema.DisplayType fieldDisplayType = fieldDescriptor.getType();
            if(fieldDisplayType == Schema.DisplayType.REFERENCE) {
                StaticLogger.debug('====parent object===={0}=={1}=={2}',  fieldDescriptor.getName(), fieldDescriptor.getLabel(), fieldDisplayType.name());
            }
        }
    }

    public static void childRelationships(Schema.SObjectType objectType) {
        StaticLogger.debug('************* Child relationships');
                // Child relationships
        for (Schema.ChildRelationship childRelation: objectType.getDescribe().getChildRelationships()) 
        {
            StaticLogger.debug('====child object==={0}', childRelation.getChildSObject());
        }
    }

    public static void fieldRelationships(Schema.SObjectType objectType) {
        StaticLogger.debug('************* Object fields');
        // <=== Alternatively
        // <=== String reference: Schema.describeSObjects(new List<String> { STRING }).get(0); e.g. Schema.describeSObjects(new List<String> { 'Account' }).get(0)...;
        // <=== Type reference: Map<String, Schema.SObjectField>  schemaMap = Schema.SObjectType.Account.fields.getMap(); // <== If you already know the type
        Map<String, Schema.SObjectField> schemaMap = objectType.getDescribe().fields.getMap();
        for(String fieldName : schemaMap.keySet()){
            DescribeFieldResult fieldDescriptor = schemaMap.get(fieldName).getDescribe();
            StaticLogger.debug('====field name==={0}=={1}=={2}', fieldDescriptor.getName(), fieldDescriptor.getRelationshipName(), fieldDescriptor.getType());
        }
    }
}