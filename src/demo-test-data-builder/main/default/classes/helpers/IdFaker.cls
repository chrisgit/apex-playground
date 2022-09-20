// Helper class for dealing with sObjects in Test
@IsTest
public class IdFaker {
    private static Integer fakeIdAutoNumber = 1;

    // Usage: IdFaker.getIdFor(SObjectType), e.g. IdFaker.getIdFor(Account.SObjectType)
    public static String getIdFor(Schema.SObjectType objectType) {
        return getIdFor(objectType, fakeIdAutoNumber++);
    }

    public static String getIdFor(Schema.SObjectType objectType, Integer fakeId) {
        return objectType.getDescribe().getKeyPrefix() + String.valueOf(fakeId).leftPad(12, '0');
    }
}
