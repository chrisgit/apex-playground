@IsTest
public with sharing class DynamicObjectJsonTests {
    @IsTest
    public static void whenSetPropertiesThenReturnViaGet() {
        DynamicObjectJson objectMap = new DynamicObjectJson();
        objectMap.product = 'Compact Blender';
        objectMap.costPrice = 1234.56;
        objectMap.category = ProductCategory.ELECTRONICS;

        System.assertEquals('Compact Blender', (String)objectMap.get('product'), 'DynamicObjectJson: product not correct');
        System.assertEquals(1234.56, (Decimal)objectMap.get('costPrice'), 'DynamicObjectJson: costPrice not correct');
        System.assertEquals(ProductCategory.ELECTRONICS, (ProductCategory)objectMap.get('category'), 'DynamicObjectJson: product not correct');
    }
}
