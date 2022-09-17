public inherited sharing class TopGraph {
    protected Map<SObjectType, Set<SObjectType>> objectDependencies = new Map<SObjectType, Set<SObjectType>>();

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

    public void addNode(SObjectType objectType) {
        if (objectDependencies.containsKey(objectType) == false) {
            objectDependencies.put(objectType, new Set<SObjectType>());
        }
    }

    public void addEdge(SobjectType childType, SObjectType parentType) {
        objectDependencies.get(childType).add(parentType);
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
