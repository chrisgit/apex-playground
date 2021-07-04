@IsTest
public class SObjectHelperTest {
    @IsTest
    public static void whenSObjectIsNullThenReturnNull() {
        Object value = SObjectHelper.getFieldValue(null, 'AccountName');

        System.assertEquals(null, value, 'SObjectHelper: SObject is null');
    }

    @IsTest
    public static void whenFieldPathIsNullThenReturnNull() {
        Account acc = new Account(Name = 'IBM', AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology');

        Object value = SObjectHelper.getFieldValue(acc, null);

        System.assertEquals(null, value, 'SObjectHelper: Field path is null');
    }

    @IsTest
    public static void whenFieldPathTopLevelSObjectThenReturnFieldValue() {
        Account acc = new Account(Name = 'IBM', AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology');

        String value = (String) SObjectHelper.getFieldValue(acc, 'AccountNumber');

        System.assertEquals('IBM001', value, 'SObjectHelper: Top level field');
    }

    @IsTest
    public static void whenFieldPathTopLevelSObjectFieldValueIsNotSetThenReturnNull() {
        Account acc = new Account(Name = 'IBM');

        String value = (String) SObjectHelper.getFieldValue(acc, 'AccountNumber');

        System.assertEquals(null, value, 'SObjectHelper: Top level field VALUE does not exist');
    }

    @IsTest
    public static void whenFieldPathTopLevelSObjectFieldDoesNotExistsThenThrowSObjectException() {
        Account acc = new Account();

        Boolean hasThrownException = false;
        try {
            Object value = SObjectHelper.getFieldValue(acc, 'AnAccountFieldThatDefinateDoesNotExistInTheDefaultOrg');
        } catch (SObjectException e) {
            hasThrownException = true;
        }

        System.assert(hasThrownException, 'SObjectHelper: Top level field does not exist');
    }

    @IsTest
    public static void whenFieldPathNestedSObjectThenReturnFieldValue() {
        Contact cnt = new Contact(Lastname = 'Daniels', Phone = '0800100200', Email = 'j.daniels@bitcorp.com');
        Account acc = new Account(Name = 'IBM', AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology');
        cnt.Account = acc;

        String value = (String) SObjectHelper.getFieldValue(cnt, 'Account.AccountNumber');

        System.assertEquals(acc.AccountNumber, value, 'SObjectHelper: Nested field value');
    }

    @IsTest
    public static void whenFieldValueOnNestedSObjectIsNotSetThenReturnNull() {
        Contact cnt = new Contact(Lastname = 'Daniels', Phone = '0800100200', Email = 'j.daniels@bitcorp.com');
        Account acc = new Account(Name = 'IBM');
        cnt.Account = acc;

        String value = (String) SObjectHelper.getFieldValue(cnt, 'Account.AccountNumber');

        System.assertEquals(null, value, 'SObjectHelper: Nested field VALUE does not exist');
    }

    @IsTest
    public static void whenNestedObjectRelationshipNotSetThenReturnNull() {
        Contact cnt = new Contact(Lastname = 'Daniels', Phone = '0800100200', Email = 'j.daniels@bitcorp.com');

        String value = (String) SObjectHelper.getFieldValue(cnt, 'Account.AccountNumber');

        System.assertEquals(null, value, 'SObjectHelper: Nested relationship not set');
    }

    @IsTest
    public static void whenNestedObjectRelationshipDoesNotExistThenThrowSObjectException() {
        Contact cnt = new Contact(Lastname = 'Daniels', Phone = '0800100200', Email = 'j.daniels@bitcorp.com');

        Boolean hasThrownException = false;
        try {
            Object value = SObjectHelper.getFieldValue(cnt, 'FieldRelationshipDoesNotExistOnContact.FieldDoesNotExistOnRelatedItem');
        } catch (SObjectException e) {
            hasThrownException = true;
        }

        System.assert(hasThrownException, 'SObjectHelper: Nested relationship does not exist');
    }
}
