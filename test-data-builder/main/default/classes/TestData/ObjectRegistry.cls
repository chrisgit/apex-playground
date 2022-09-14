public inherited sharing class ObjectRegistry {

     public static void insertUsingUnitOfWork(Set<TestObject> testObjects) {        
        Set<TestObject> registerAsNew = new Set<TestObject>(); 
        List<SObjectType> insertOrder = new TopGraph(testObjects).sort();
        System.Debug('Insert order for UoW is ' + insertOrder);
       SimpleUnitOfWork dataUow = new SimpleUnitOfWork(insertOrder);
        SObject record;
        SObject parentRecord;
        for(TestObject obj: testObjects) {
            record = obj.getRecord();
            System.Debug('Registering record ' + record);
            if(record.Id == null) {
                dataUoW.registerNew(record);
            }

            for(SObjectField rel: obj.parentRelationships.keySet()) {
                TestObject parent = obj.parentRelationships.get(rel);
                if (parent == null) {
                    continue;
                }
                parentRecord = parent.getRecord();
                string debugMessage = string.format('Registering relationship for {0} on field {1} to object {2}', new object[] { record, rel, parentRecord });
                System.Debug(debugMessage);
                dataUow.registerRelationship(obj.getRecord(), rel, parentRecord);
            }    
        }

        dataUow.commitWork();
    }

    public static void simpleInsert(Set<TestObject> testObjects) {       
        List<SObjectType> insertOrder = new TopGraph(testObjects).sort();
        System.Debug('Insert order for UoW is ' + insertOrder);

        List<TestObject> objectsToInsert;
        for (SObjectType objectType : insertOrder) {
            objectsToInsert = new List<TestObject>();
            for(TestObject obj : testObjects) {
                if (obj.type == objectType) {
                    objectsToInsert.add(obj);
                }
            }
            doInsert(objectsToInsert);
        }
    }

    private static void doInsert(List<TestObject> objectsToInsert) {
        List<SObject> sobjectsToInsert = new List<SObject>();
        SObject record;
        SObject parentRecord;
        for(TestObject obj : objectsToInsert) {
            record = obj.getRecord();
            for(SObjectField relatedField : obj.parentRelationships.keySet()) {
                TestObject parent = obj.parentRelationships.get(relatedField);
                if (parent == null) {
                    continue;
                }
                parentRecord = parent.getRecord();
                record.put(relatedField, parentRecord.Id);
            }    

            sobjectsToInsert.add(record);
        }

        insert sobjectsToInsert;
    }
}