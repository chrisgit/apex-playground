@IsTest
public with sharing class AbstractClassTests {
    @IsTest
    public static void whenDowncastAsBaseThenReturnActual() {
        AbstractPrice base = new AbstractRegular();

        System.assertEquals('Regular Price', base.name(), 'Abstract Price name() not correct');
    }

    @IsTest
    public static void whenCastAsInterfaceThenReturnInterfaceMethod() {
        IPromotion base = new AbstractRegular();

        System.assertEquals('Promotion - Regular Price', base.promotion(), 'Interface Price promotion not correct');
    }
}
