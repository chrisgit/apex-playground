public inherited sharing class TestDataRegistry {

     public static void insertUsingUnitOfWork(Set<TestDataObject> testObjects) {
        List<SObjectType> insertOrder = getObjectHierarchy(testObjects);
        System.Debug('Insert order for UoW is ' + insertOrder);
        SimpleUnitOfWork dataUow = new SimpleUnitOfWork(insertOrder);
        SObject record;
        SObject parentRecord;
        for(TestDataObject obj: testObjects) {
            record = obj.getRecord();
            System.Debug('Registering record ' + record);
            if(record.Id == null) {
                dataUoW.registerNew(record);
            }

            for(SObjectField rel: obj.parentRelationships.keySet()) {
                TestDataObject parent = obj.parentRelationships.get(rel);
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

    public static void simpleInsert(Set<TestDataObject> testObjects) {       
        List<SObjectType> insertOrder = getObjectHierarchy(testObjects);
        System.Debug('Insert order for UoW is ' + insertOrder);

        List<TestDataObject> objectsToInsert;
        for (SObjectType objectType : insertOrder) {
            objectsToInsert = new List<TestDataObject>();
            for(TestDataObject obj : testObjects) {
                if (obj.type == objectType) {
                    objectsToInsert.add(obj);
                }
            }
            doInsert(objectsToInsert);
        }
    }

    private static void doInsert(List<TestDataObject> objectsToInsert) {
        List<SObject> sobjectsToInsert = new List<SObject>();
        SObject record;
        SObject parentRecord;
        for(TestDataObject obj : objectsToInsert) {
            record = obj.getRecord();
            for(SObjectField relatedField : obj.parentRelationships.keySet()) {
                TestDataObject parent = obj.parentRelationships.get(relatedField);
                if (parent == null) {
                    continue;
                }
                parentRecord = parent.getRecord();
                // The parent record will have already been updated or set elsewhere 
                // Therefore ensure the field is updated in this child record
                record.put(relatedField, parentRecord.Id);
            }    

            // Ignore if already has an Id
            if (record.Id == null) {
                sobjectsToInsert.add(record);
            }
        }

        insert sobjectsToInsert;
    }

    private static List<SObjectType> getObjectHierarchy(Set<TestDataObject> objects) {
        TopGraph graph = new TopGraph();
        for(TestDataObject obj : objects) {
            graph.addNode(obj.type);

            for(SObjectField rel : obj.parentRelationships.keySet()) {
                TestDataObject parent = obj.parentRelationships.get(rel);
                if (parent == null) {
                    continue;
                }
                graph.addNode(parent.type);
                graph.addEdge(obj.type, parent.type);
            }
        }
        return graph.sort();
    }
}