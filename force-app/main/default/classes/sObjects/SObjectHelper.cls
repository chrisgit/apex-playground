// Helper class for dealing with sObjects
public inherited sharing class SObjectHelper {
    public static Object getFieldValue(SObject sfObject, String dotPath) {
        return descendObjectToGetFieldValue(sfObject, dotPath);
    }

    private static Object descendObjectToGetFieldValue(SObject sfObject, String dotPath) {
        if (sfObject == null || String.isBlank(dotPath)) {
            return null;
        }

        List<String> pathSegments = dotPath.split('\\.');
        if (pathSegments.size() == 1) {
            return sfObject.get(pathSegments[0]);
        }

        SObject relatedSObject = sfObject.getSObject(pathSegments[0]);
        pathSegments.remove(0);
        return descendObjectToGetFieldValue(relatedSObject, String.join(pathSegments, '.'));
    }
}
