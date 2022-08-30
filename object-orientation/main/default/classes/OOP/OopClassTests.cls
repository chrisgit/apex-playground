@IsTest
public with sharing class OopClassTests {
    @IsTest
    public static void whenDowncastAsBaseThenReturnActual() {
        OopAbstractBase base = new OopField();

        System.assertEquals('OopField', base.showClass(), 'OopField showClass not correct');
    }

    @IsTest
    public static void whenCastAsInterface() {
        IOopBase base = new OopField();

        System.assertEquals('Interface - OopField', base.showUnderlyingClass(), 'OopField field interface not correct');
    }

    @IsTest
    public static void whenVirtualClassThenReturnActual() {
        VirtualBase base = new VirtualBase();

        System.assertEquals('VirtualBase', base.showClass(), 'VirtualBase showClass not correct');
    }

    @IsTest
    public static void whenVirtualDowncastThenReturn() {
        VirtualBase base = new VirtualField();

        System.assertEquals('VirtualField', base.showClass(), 'VirtualField showClass not correct');
    }
}
