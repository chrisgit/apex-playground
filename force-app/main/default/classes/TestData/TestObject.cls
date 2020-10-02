public abstract class TestObject {

    public Map<SObjectField, TestObject> parentRelationships = new Map<SObjectField, TestObject>();

    public SObject record;
    public Id id { private set; get {return record.Id;} }
    public SObjectType type;

    public TestObject(SObjectType type) {
        this.type = type;
        this.record = type.newSObject(null, true);

        ObjectRegistry.objects.add(this);
    }

    public TestObject recordType(String developerName) {
        Id rtId = type.getDescribe().getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
        return set('RecordTypeId', rtId);
    }

    protected void setParent(SObjectField relationship, TestObject newParent) {
        TestObject currentParent = parentRelationships.get(relationship);

        parentRelationships.remove(relationship);
        if (newParent != null) {
            parentRelationships.put(relationship, newParent);
        }

        if(currentParent != null && currentParent != newParent) {
            currentParent.removeFromObjectRegistry();
        }

        if(newParent != null) {
            newParent.addToObjectRegistry();
        }
    }

    protected TestObject set(String fieldName, Object value) {
        record.put(fieldName, value);
        return this;
    }

    protected TestObject set(SObjectField field, Object value) {
        record.put(field, value);
        return this;
    }

    protected void removeFromObjectRegistry() {
        ObjectRegistry.objects.remove(this);

        for(TestObject parent : parentRelationships.values()) {
            parent.removeFromObjectRegistry();
        }
    }

    protected void addToObjectRegistry() {
        if(record.Id == null && ObjectRegistry.objects.contains(this) == false) {
            ObjectRegistry.objects.add(this);

            for(TestObject parent: parentRelationships.values()) {
                parent.addToObjectRegistry();
            }
        }
    }
}
