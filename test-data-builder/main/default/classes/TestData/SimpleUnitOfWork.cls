public inherited sharing class SimpleUnitOfWork {
    protected List<Schema.SObjectType> objectTypes = new List<Schema.SObjectType>();

    protected Map<String, List<SObject>> itemsToAdd = new Map<String, List<SObject>>();
    protected Map<String, Map<Id, SObject>> itemsToUpdate = new Map<String, Map<Id, SObject>>();
    protected Map<String, Map<Id, SObject>> itemsToDelete = new Map<String, Map<Id, SObject>>();
    protected Map<String, Relationships> objectRelationships = new Map<String, Relationships>();

    protected IDML dml;

    public SimpleUnitOfWork(List<Schema.SObjectType> sObjectTypes)
    {
        dml = new SimpleDML();
        objectTypes = sObjectTypes.clone();
        for(Schema.SObjectType sObjectType : objectTypes)
        {
            handleRegisterType(sObjectType);
        }
    }

    public void registerNew(SObject record)
    {
        String sObjectType = record.getSObjectType().getDescribe().getName();
        itemsToAdd.get(sObjectType).add(record);
    }

    public void registerRelationship(SObject record, Schema.sObjectField relatedToField, SObject relatedTo)
    {
        String sObjectType = record.getSObjectType().getDescribe().getName();
        objectRelationships.get(sObjectType).add(record, relatedToField, relatedTo);
    }

    public void commitWork()
    {
        Savepoint sp = Database.setSavePoint();
        Boolean wasSuccessful = false;
        try
        {
            for(Schema.SObjectType sObjectType : objectTypes)
            {
                Boolean hasSelfLookup = objectRelationships.get(sObjectType.getDescribe().getName()).resolve();
                dml.dmlInsert(itemsToAdd.get(sObjectType.getDescribe().getName()));

                if(hasSelfLookup) {
                    objectRelationships.get(sObjectType.getDescribe().getName()).resolve();
                    dml.dmlUpdate(itemsToAdd.get(sObjectType.getDescribe().getName()));
                }
            }

            for(Schema.SObjectType sObjectType : objectTypes) {
                dml.dmlUpdate(itemsToUpdate.get(sObjectType.getDescribe().getName()).values());
            }

            Integer objectIdx = objectTypes.size() - 1;
            while(objectIdx >= 0) {
                dml.dmlDelete(itemsToDelete.get(objectTypes[objectIdx--].getDescribe().getName()).values());
            }

            wasSuccessful = true;
        }
        catch (Exception e)
        {
            Database.rollback(sp);
            throw e;
        }
    }

    private void handleRegisterType(Schema.SObjectType sObjectType)
    {
        itemsToAdd.put(sObjectType.getDescribe().getName(), new List<SObject>());
        itemsToUpdate.put(sObjectType.getDescribe().getName(), new Map<Id, SObject>());
        itemsToDelete.put(sObjectType.getDescribe().getName(), new Map<Id, SObject>());
        objectRelationships.put(sObjectType.getDescribe().getName(), new Relationships());
    }

    public interface IDML
    {
        void dmlInsert(List<SObject> objList);
        void dmlUpdate(List<SObject> objList);
        void dmlDelete(List<SObject> objList);
    }

    public class SimpleDML implements IDML
    {
        public void dmlInsert(List<SObject> objList){
            insert objList;
        }
        public void dmlUpdate(List<SObject> objList){
            update objList;
        }
        public void dmlDelete(List<SObject> objList){
            delete objList;
        }
    }

    private interface IRelationship
    {
        void resolve();
        Boolean isSelfLookup();
    }

    private class Relationships
    {
        private List<IRelationship> relationships = new List<IRelationship>();

        public Boolean resolve()
        {
            Boolean result = false;

            for(IRelationship relationship : relationships)
            {
                relationship.resolve();
                result = result || relationship.isSelfLookup();
            }

            return result;
        }

        public void add(SObject record, Schema.sObjectField relatedToField, SObject relatedTo)
        {
            Relationship relationship = new Relationship();
            relationship.Record = record;
            relationship.RelatedToField = relatedToField;
            relationship.RelatedTo = relatedTo;
            relationships.add(relationship);
        }
    }

    private class Relationship implements IRelationship
    {
        public SObject record;
        public Schema.sObjectField relatedToField;
        public SObject relatedTo;

        public void resolve()
        {
            this.record.put( this.relatedToField, this.relatedTo.Id);
        }

        public Boolean isSelfLookup() {
            return record.getSObjectType() == relatedTo.getSObjectType();
        }
    }

    public class UnitOfWorkException extends Exception {}
}
