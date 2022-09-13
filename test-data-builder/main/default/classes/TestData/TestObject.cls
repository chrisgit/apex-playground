// Ideally requires equals and hashcode methods
public abstract class TestObject {

    // Actually just needs a tuple
    public Map<SObjectField, TestObject> parentRelationships {
        private set {
            parentRelationships = value;
        }
        get {
            if (parentRelationships == null) {
                parentRelationships = new Map<SObjectField, TestObject>();
            }
            return parentRelationships;
        }
    }

    public SObjectType type;

    public TestObject(SObjectType type) {
        this.type = type;
    }

    // Re-add SObject record but do not reference from inherited class, only used when abstract of test object used
    public abstract SObject getRecord();

    public TestObject recordType(String developerName) {
        Id rtId = type.getDescribe().getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
        getRecord().put('RecordTypeId', rtId);
        return this;
    }

    protected TestObject setParent(SObjectField relationship, TestObject newParent) {
        parentRelationships.put(relationship, newParent);
        return this;
    }

    protected TestObject getParent(SObjectField relationship) {
        return parentRelationships.get(relationship);
    }
}