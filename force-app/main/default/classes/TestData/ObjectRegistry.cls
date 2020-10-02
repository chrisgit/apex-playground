public inherited sharing class ObjectRegistry {
    public static Set<TestObject> objects = new Set<TestObject>();

     public static void persist() {
        SimpleUnitOfWork dataUow = unitOfWork();
        for(TestObject obj: objects) {

            if(obj.record.Id == null) {
                dataUow.registerNew(obj.record);
            }

            for(SObjectField rel: obj.parentRelationships.keySet()) {
                TestObject parent = obj.parentRelationships.get(rel);
                dataUow.registerRelationship(obj.record, rel, parent.record);
            }
        }

        dataUow.commitWork();
        objects.clear();
    }

    private static SimpleUnitOfWork unitOfWork() {
        List<SObjectType> insertOrder = new TopGraph(objects).sort();
        return new SimpleUnitOfWork(insertOrder);
    }
}
