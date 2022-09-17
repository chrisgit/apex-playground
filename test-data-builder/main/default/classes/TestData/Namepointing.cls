public with sharing class Namepointing {
    private static TopGraph graph;

    public static void simpleInsert(List<SObject> allObjects) {
        if (allObjects.isEmpty()) {
            return;
        }
        graph = new TopGraph();
        List<SObject> unlistedParentObjects = new List<SObject>();
        for(SObject currentObject : allObjects) {
            ascendAddUnlistedParents(allObjects, unlistedParentObjects, currentObject);
        }
        allObjects.addAll(unlistedParentObjects);
        List<SObjectType> insertOrder = graph.sort();

        // Using the list insert
        List<SObject> objectsToInsert;
        for (SObjectType objectType : insertOrder) {
            objectsToInsert = new List<SObject>();
            for(SObject obj : allObjects) {
                if (obj.getSObjectType() == objectType) {
                    objectsToInsert.add(obj);
                }
            }
            doInsert(objectsToInsert);
        }
    }

    private static void ascendAddUnlistedParents(List<SObject> allObjects, List<SObject> unlistedParentObjects, SObject currentObject) {
        graph.addNode(currentObject.getSObjectType());
        Map<String, Object> populatedFields = currentObject.getPopulatedFieldsAsMap();
        Map<String, String> parentRelationships = getParentRelationshipsForObject(currentObject);
        for(String field : populatedFields.keySet()) {
            if (parentRelationships.containsKey(field)) {
                SObject relatedObject = (SObject)populatedFields.get(field);
                graph.addEdge(currentObject.getSObjectType(), relatedObject.getSObjectType());
                if (allObjects.contains(relatedObject) == false && unlistedParentObjects.contains(relatedObject) == false) {
                    unlistedParentObjects.add(relatedObject);
                    ascendAddUnlistedParents(allObjects, unlistedParentObjects, relatedObject);
                }
            }
        }
    }

    private static void doInsert(List<SObject> objectsToInsert) {
        Map<String, Object> populatedFields;
        Map<String, String> parentRelationships;
        SObject record;
        SObject parentRecord;
        for(SObject obj : objectsToInsert) {
            populatedFields = obj.getPopulatedFieldsAsMap();
            parentRelationships = getParentRelationshipsForObject(obj);
            for(String field : populatedFields.keySet()) {
                if (parentRelationships.containsKey(field)) {
                    SObject parentObject = (SObject)populatedFields.get(field);
                    String idFieldForRelationship = parentRelationships.get(field);
                    obj.put(idFieldForRelationship, parentObject.Id);
                }
            }
        }
        insert objectsToInsert;
    }

    private static Map<SObjectType, Map<String, String>> cachedParentRelationships = new Map<SObjectType, Map<String, String>>();
    private static Map<String, String> getParentRelationshipsForObject(SObject obj) {
        SObjectType type = obj.getSObjectType();
        if (cachedParentRelationships.containsKey(type)) {
            System.Debug('Returning parent fields from cache for ' + type);
            return cachedParentRelationships.get(type);
        }

        DescribeSObjectResult objectResult = Opportunity.SObjectType.getDescribe();
        Map<String, SObjectField> objectFields = objectResult.fields.getMap();
        Map<String, String> parentFields = new Map<String, String>();
        for(SObjectField fld : objectFields.values()) {
            DescribeFieldResult fldResult = fld.getDescribe();
            If (fldResult.getType() == Schema.DisplayType.REFERENCE) {
                // Contact etc standard objects or custom objects with __r, needs to look at namepointing etc
                if (fldResult.getRelationshipName() == null) {
                    List<SObjectType> relatedTypes = fldResult.getReferenceTo();
                    parentFields.put(relatedTypes.get(0).getDescribe().getName(), fldResult.getName());
                } else {
                    parentFields.put(fldResult.getRelationshipName(), fldResult.getName());
                }
            }
        }

        cachedParentRelationships.put(type, parentFields);

        return parentFields;
    }
}


/*
// Works
Account acc = new Account(Name='Test Account');
Opportunity opp = new Opportunity(Name='Test Opportunity', CloseDate=Date.newInstance(2022, 12, 1), StageName='Open');
opp.Account=acc;

// Pretend to be Namepointing.insert() method
insert acc;
opp.put('AccountId', opp.Account.Id);
insert opp;
*/