public inherited sharing class DynamicObjectMap {
    protected Map<String, Object> fields = new Map<String, Object>();
    public String product {
        get {
            return (String)fields.get('product');
        }
        set {
            fields.put('product', value);
        }
    }

    public ProductCategory category {
        get {
            return (ProductCategory)fields.get('category');
        }
        set {
            fields.put('category', value);
        }
    } 

    public Decimal costPrice {
        get {
            return (Decimal)fields.get('costPrice');
        }
        set {
            fields.put('costPrice', value);
        }
    }

    public Object get(String fieldName) {
        return fields.get(fieldName);
    }
}
