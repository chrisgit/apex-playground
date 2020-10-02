public with sharing class DynamicObjectJson {
    Map<String, ProductCategory> categoryMap = new Map<String, ProductCategory>();
    public String product;
    public ProductCategory category;
    public Decimal costPrice;

    public Object get(String fieldName) {
        Map<String, Object> fields = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(this));
        Object fieldValue = fields.get(fieldName);
        if (fieldName == 'category') {
            fieldValue = stringToCategory((String)fieldValue);
        }
        return fieldValue;
    }

    private ProductCategory stringToCategory(String productCategory) {
        if (categoryMap.isEmpty()) {

            populateCategoryMap();
        }
        return categoryMap.get(productCategory);
    }

    private void populateCategoryMap() {
        for (ProductCategory category: ProductCategory.values()) {
            categoryMap.put(category.name(), category);
        }            
    } 
}
