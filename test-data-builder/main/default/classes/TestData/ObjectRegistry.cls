public inherited sharing class ObjectRegistry {

     public static void persist(Set<TestObject> testObjects) {        
        // Would not work as SObject because of equality issues
        Set<TestObject> registerAsNew = new Set<TestObject>(); 
        
        SimpleUnitOfWork dataUow = unitOfWork(testObjects);
        SObject record;
        SObject parentRecord;
        for(TestObject obj: testObjects) {
            record = obj.getRecord();
            System.Debug('Registering record ' + record);
            if(record.Id == null) {
                registerAsNew.add(obj);
            }

            // Ascend all parent objects
            addParents(obj, registerAsNew, dataUow);
        }
         
         for(TestObject o : registerAsNew) {         
             dataUoW.registerNew(o.getRecord());
         }
         
        dataUow.commitWork();
    }

    private static void addParents(TestObject obj, Set<TestObject> registerAsNew, SimpleUnitOfWork dataUow) {
        for(SObjectField rel: obj.parentRelationships.keySet()) {
            TestObject parent = obj.parentRelationships.get(rel);
            if (parent == null) {
                continue;
            }
            Sobject parentRecord = parent.getRecord();
            System.Debug('Registering relationships ' + rel + ' ' + parentRecord);
            dataUow.registerRelationship(obj.getRecord(), rel, parentRecord);

            if (parentRecord.Id == null && registerAsNew.contains(parent) == false) {
                System.Debug('Adding parent record ' + parentRecord);
                //dataUoW.registerNew(parentRecord); // Would not work if parent registered more than once
                registerAsNew.add(parent);
                addParents(parent, registerAsNew, dataUow);                
            }
        }
    }

    private static SimpleUnitOfWork unitOfWork(Set<TestObject> testObjects) {
        List<SObjectType> insertOrder = new TopGraph(testObjects).sort();
        System.Debug('Insert order for UoW is ' + insertOrder);
        return new SimpleUnitOfWork(insertOrder);
    }
}