public with sharing class Automapper {
    Map<String, String> fieldMap = new Map<String, String>();
    Map<String, Object> dtoMap;

    public Automapper( Map<String, String> fieldMap) {
        this.fieldMap = fieldMap;
    }

    public AbstractDto createDTOFromSObject(SObject objectToMap, Type dto) {
        dtoMap = new Map<String, Object>();
        fieldMap = fieldMap;

        for (String key : fieldMap.keySet()) {
            String dtoField = key;
            String sObjectField = fieldMap.get(dtoField);

            Object dtoValue = getSObjectValue(objectToMap, sObjectField);
            if (null != dtoValue) {
                setDtoValue(dtoField, dtoValue);
            }
        }

        String dtoAsJson = JSON.serialize(dtoMap);
        return (AbstractDto)JSON.deserialize(dtoAsJson, dto);
    }

    private Object getSobjectValue(SObject objecttoMap, String fieldPath) {
        List<String> pathSegments = fieldPath.split('\\.');
        Map<String, Object> currentObjectMap = objectToMap.getPopulatedFieldsAsMap();

        for (Integer i = 0; i < pathSegments.size() - 1; i++) {
            String relationship = pathSegments.get(i);
            SObject relatedObject = (SObject)(currentObjectMap.get(relationship));
            if (null == relatedObject) {
                currentObjectMap = null;
                break;
            }
            currentObjectMap = relatedObject.getPopulatedFieldsAsMap();
        }
        String fieldName = pathSegments[pathSegments.size() - 1];
        Object fieldValue = null == currentObjectMap ? null : currentObjectMap.get(fieldName);
        return fieldValue;
    }

    private void setDtoValue(String apiFieldName, Object apiFieldValue) {
        List<String> pathSegments = apiFieldName.split('\\.');
        Map<String, Object> currentObjectMap = dtoMap;

        for (Integer i = 0; i < pathSegments.size() - 1; i++) {
            String apiDtoName = pathSegments.get(i);
            if (currentObjectMap.containsKey(apiDtoName) == false) {
                currentObjectMap.put(apiDtoName, new Map<String, Object>());
            }
            currentObjectMap = (Map<String, Object>) currentObjectMap.get(apiDtoName);
        }
        String fieldName = pathSegments[pathSegments.size() - 1];
        currentObjectMap.put(fieldName, apiFieldValue);
    }
}
