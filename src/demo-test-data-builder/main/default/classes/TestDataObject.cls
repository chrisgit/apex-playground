// Ideally requires equals and hashcode methods
public abstract class TestDataObject {

    // Actually just needs a tuple
    public Map<SObjectField, TestDataObject> parentRelationships {
        private set {
            parentRelationships = value;
        }
        get {
            if (parentRelationships == null) {
                parentRelationships = new Map<SObjectField, TestDataObject>();
            }
            return parentRelationships;
        }
    }

    public SObjectType type;

    public TestDataObject(SObjectType type) {
        this.type = type;
    }

    // Re-add SObject record but do not reference from inherited class, only used when abstract of test object used
    public abstract SObject getRecord();

    public TestDataObject recordType(String developerName) {
        Id rtId = type.getDescribe().getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
        getRecord().put('RecordTypeId', rtId);
        return this;
    }

    protected TestDataObject setParent(SObjectField relatedField, TestDataObject parentObject) {
        parentRelationships.put(relatedField, parentObject);
        return this;
    }

    protected TestDataObject getParent(SObjectField relatedField) {
        return parentRelationships.get(relatedField);
    }
}