@IsTest
public with sharing class QuirkyAddTests {
    @IsTest
    public static void whenCallingStaticMethodThatFormsInterface() {
        System.assertEquals(QuirkyAdd.add(3, 4), 7, 'QuirkyAddTests: cannot call static method');
    }

    @IsTest
    public static void whenCallingStaticMethodFromInstance() {
        QuirkyAdd quirkyAddInstance = new QuirkyAdd();

        // Static method cannot be referenced from a non static context: Integer QuirkyAdd.add(Integer, Integer) (12:46)
        // System.assertEquals(quirkyAddInstance.add(5, 6), 11, 'QuirkyAddTests: cannot call static method from instance');
        System.assert(true, 'QuirkyAddTests: cannot call static method from instance (hard coded assert');
    }

    @IsTest
    public static void whenCallingStaticMethodFromInstanceAsInterface() {
        IQuirkyAdd quirkyAddInstance = new QuirkyAdd();

        // We have an instance of QuirkyAdd by cast to the interface ... can still call the static method
        System.assertEquals(quirkyAddInstance.add(5, 6), 11, 'QuirkyAddTests: cannot call interface method');
    }
}
