public inherited sharing class TopGraph {
    protected Map<SObjectType, Set<SObjectType>> objectDependencies = new Map<SObjectType, Set<SObjectType>>();

    public TopGraph(Set<TestObject> objects)
    {
        for(TestObject obj : objects) {
            addNode(obj.type);

            for(SObjectField rel : obj.parentRelationships.keySet()) {
                TestObject parent = obj.parentRelationships.get(rel);
                if (parent == null) {
                    continue;
                }
                addNode(parent.type);
                addEdge(obj.type, parent.type);
            }
        }
    }

    public List<SObjectType> sort()
    {
        List<SObjectType> objectQueue = new List<SObjectType>();

        Map<SObjectType, Boolean> visited = new Map<SObjectType, Boolean>();
        for (SObjectType objectType : objectDependencies.keySet())
        {
            visited.put(objectType, false);
        }

        for (SObjectType objectType : objectDependencies.keySet()) {
            if (visited.get(objectType) == false)
            {
                topologicalSort(objectType, visited, objectQueue);
            }
        }

        return objectQueue;
    }

    private void addNode(SObjectType objectType) {
        if (objectDependencies.containsKey(objectType) == false) {
            objectDependencies.put(objectType, new Set<SObjectType>());
        }
    }

    private void addEdge(SobjectType child, SObjectType parent) {
        objectDependencies.get(child).add(parent);
    }

    private void topologicalSort(SObjectType objectType, Map<SObjectType, Boolean> visited, List<SObjectType> objectQueue)
    {
        visited.put(objectType, true);
        SObjectType currentObject;

        Set<SObjectType> parentRelations = objectDependencies.get(objectType);
        Iterator<SObjectType> it = parentRelations.iterator();
        while (it.hasNext())
        {
            currentObject = it.next();
            if (visited.get(currentObject) == false) {
                topologicalSort(currentObject, visited, objectQueue);
            }
        }

        objectQueue.add(objectType);
    }
}
