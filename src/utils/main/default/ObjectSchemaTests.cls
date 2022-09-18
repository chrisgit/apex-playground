@IsTest
public with sharing class ObjectSchemaTests {
    @IsTest
    public static void whengetFieldThenReturnFieldDescription() {
        ObjectSchema oSchema = new ObjectSchema(Schema.sObjectType.Account);

        Schema.SObjectField field = oSchema.getField('name');

        System.assertEquals(Account.Name, field, 'ObjectSchema getFieldDescription did not return matched field');
    }

    @IsTest
    public static void whengetFieldDescriptionThenReturnFieldDescription() {
        ObjectSchema oSchema = new ObjectSchema(Schema.sObjectType.Account);

        DescribeFieldResult field = oSchema.getFieldDescription('name');

        System.assertEquals('Name', field.getName(), 'ObjectSchema getFieldDescription did not return matched field');
        //System.assertEquals(Schema.sObjectType.Account.fields.Name, field, 'ObjectSchema getFieldDescription did not return matched field');
        //System.assertEquals(Account.Name.getDescribe(), field, 'ObjectSchema getFieldDescription did not return matched field');
    }

    @IsTest
    public static void whengetFieldDescriptionAndFieldDoesNotExistOnSObjectThenReturnNull() {
        ObjectSchema oSchema = new ObjectSchema(Schema.sObjectType.Account);

        DescribeFieldResult field = oSchema.getFieldDescription('this_field_does_not_exist_on_account_object');

        System.assertEquals(null, field, 'ObjectSchema getFieldDescription did not return null');
    }
}
