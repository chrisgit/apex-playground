@IsTest
public with sharing class ObjectFactoryTests {
    @IsTest
    public static void whenGetSchemaForSObjectThenReturnObjectSchema() {
        ObjectSchema schema = ObjectFactory.getSchemaForSObject('Account');

        System.assertEquals('Account', schema.name, 'ObjectFactory did not return Account schema');
    }

    @IsTest
    public static void whenSuccessiveCallsToGetSchemaForSObjectThenReturnCachedObject() {
        ObjectSchema schemaCallOne = ObjectFactory.getSchemaForSObject('Account');
        ObjectSchema schemaCallTwo = ObjectFactory.getSchemaForSObject('Account');

        System.assert (schemaCallOne === schemaCallTwo, 'ObjectFactory did not return cached schema');
    }
}
