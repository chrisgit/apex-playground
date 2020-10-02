@IsTest
public with sharing class DynamicMethodCallTests {
    @IsTest
    public static void whenCallingPromotionThenPromotionApplied() {
        DynamicMethodCall dmc = new DynamicMethodCall('kitchen mixer', 299.99);

        dmc.startPromotion('Winter Sale', 229.99);

        System.assertEquals(229.99, dmc.price, 'DynamicMethodCall: promotion direct method call item price not updated');
        System.assert(dmc.onPromotion(), 'DynamicMethodCall: promotion direct method call item promotion not updated');

        dmc.endPromotion();

        System.assertEquals(299.99, dmc.price, 'DynamicMethodCall: end promotion direct method call item price not updated');
        System.assert(dmc.onPromotion() == false, 'DynamicMethodCall: end promotion direct method call item promotion not updated');
    }

    @IsTest
    public static void whenCallingPromotionWithCallableThenPromotionApplied() {
        DynamicMethodCall dmc = new DynamicMethodCall('kitchen mixer', 299.99);

        dmc.call('startPromotion', new Map<String, Object> { 'promotionReason' => 'Flash Sale', 'promotionPrice' => 219.99 });

        System.assertEquals(219.99, dmc.price, 'DynamicMethodCall: promotion via callable item price not updated');
        System.assert(dmc.onPromotion(), 'DynamicMethodCall: promotion via callable item promotion not updated');

        dmc.call('endPromotion', new Map<String, Object>());
        
        System.assertEquals(299.99, dmc.price, 'DynamicMethodCall: end promotion direct method call item price not updated');
        System.assert(dmc.onPromotion() == false, 'DynamicMethodCall: end promotion direct method call item promotion not updated');
    }    
}
