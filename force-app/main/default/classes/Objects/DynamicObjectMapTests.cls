@IsTest
public with sharing class DynamicObjectMapTests {
    @IsTest
    public static void whenSetPropertiesThenReturnViaGet() {
        DynamicObjectMap objectMap = new DynamicObjectMap();
        objectMap.product = 'Compact Blender';
        objectMap.costPrice = 1234.56;
        objectMap.category = ProductCategory.ELECTRONICS;

        System.assertEquals('Compact Blender', (String)objectMap.get('product'), 'DynamicObjectMap: product not correct');
        System.assertEquals(1234.56, (Decimal)objectMap.get('costPrice'), 'DynamicObjectMap: costPrice not correct');
        System.assertEquals(ProductCategory.ELECTRONICS, (ProductCategory)objectMap.get('category'), 'DynamicObjectMap: product not correct');
    }
}
