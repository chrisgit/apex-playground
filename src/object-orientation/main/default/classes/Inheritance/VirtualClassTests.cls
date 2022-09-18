@IsTest
public with sharing class VirtualClassTests {

    @IsTest
    public static void whenVirtualClassThenReturnActual() {
        VirtualPrice base = new VirtualPrice();

        System.assertEquals('Virtual Price', base.name(), 'Virtual Price name() not correct');
    }

    @IsTest
    public static void whenVirtualDowncastThenReturnVirtual() {
        VirtualPrice base = new VirtualRegular();

        System.assertEquals('Virtual Regular', base.name(), 'Virtual Regular downcast name() not correct');
    }
}
