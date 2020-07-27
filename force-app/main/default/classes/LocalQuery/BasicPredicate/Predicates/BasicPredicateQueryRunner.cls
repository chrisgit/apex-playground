public with sharing class BasicPredicateQueryRunner {
    public static List<SObject> filterData(List<SObject> objects, BasePredicate condition) {
        List<sObject> selectedObjects = new List<sObject>();

        for (SObject sobj : objects) {
            if (condition.evaluate(sobj)) {
                selectedObjects.add(sobj);
            }
        }

        return selectedObjects;        
    }
}
