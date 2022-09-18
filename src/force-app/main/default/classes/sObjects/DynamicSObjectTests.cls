@IsTest
public inherited sharing class DynamicSObjectTests {
    public static final String CONTACT_EMAIL_FIELD_NAME = 'Email';
    public static final SObjectField CONTACT_EMAIL_FIELD_REFERENCE = Schema.Contact.Email;
    public static final String TEST_EMAIL_ADDRESS = 'test@email.com';

    public static final String ACCOUNT_SOBJECT_NAME = 'Account';
    public static final Schema.SObjectType ACCOUNT_SOBJECT_TYPE = Schema.Account.getSObjectType();

    // This example demonstrates using get and put for sObjects with strings
    @IsTest
    public static void whenUsingPutWithStringThenRetrieveValueWithGet() {
        Contact exampleContact = new Contact();

        exampleContact.put(CONTACT_EMAIL_FIELD_NAME, TEST_EMAIL_ADDRESS);
        
        System.assertEquals(TEST_EMAIL_ADDRESS, String.valueof(exampleContact.get(CONTACT_EMAIL_FIELD_NAME)));
    }

    // This example demonstrates using get and put for sObjects with schema reference
    @IsTest
    public static void whenUsingPutWithFieldReferenceThenRetrieveValueWithGet() {
        Contact exampleContact = new Contact();

        exampleContact.put(CONTACT_EMAIL_FIELD_REFERENCE, TEST_EMAIL_ADDRESS);
        
        System.assertEquals(TEST_EMAIL_ADDRESS, String.valueof(exampleContact.get(CONTACT_EMAIL_FIELD_REFERENCE)));
    }

    // Taking the name of an sObject as a string and creating an instance from it using newSObject
    @IsTest
    public static void whenSObjectNameIsStringCreateWithNewSobjectThenInstanceCreated() {
        Schema.SObjectType objectType = Schema.getGlobalDescribe().get(ACCOUNT_SOBJECT_NAME);

        Sobject genericObject = objectType.newSObject(); // <== Would need to cast it

        System.assert(genericObject instanceof Account);
    }

    // Taking the name of an sObject as a string and creating an instance from it using Type.forName
    @IsTest
    public static void whenSObjectNameIsStringCreateWithTypeForNameThenInstanceCreated() {
        Sobject genericObject = ((SObject) Type.forName(ACCOUNT_SOBJECT_NAME).newInstance());

        System.assert(genericObject instanceof Account);
        System.assertEquals(ACCOUNT_SOBJECT_TYPE, genericObject.getSObjectType());
    }

}
