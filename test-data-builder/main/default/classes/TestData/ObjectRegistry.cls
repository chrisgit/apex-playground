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

    private static SimpleUnitOfWork unitOfWork(Set<TestObject> testObjects) {
        List<SObjectType> insertOrder = new TopGraph(testObjects).sort();
        System.Debug('Insert order for UoW is ' + insertOrder);
        return new SimpleUnitOfWork(insertOrder);
    }
}