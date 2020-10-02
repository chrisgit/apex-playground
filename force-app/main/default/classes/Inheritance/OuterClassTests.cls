@IsTest
public with sharing class OuterClassTests {
    @IsTest
    public static void whenConstructingOuterClass() {
        // Construct an instance of an inner concrete class, with a user-defined constructor
        OuterClass.InnerClass ic = new OuterClass.InnerClass('x');

        // Call user-defined methods in the class
        System.assertEquals(2, ic.method2(1));

        // Define a variable with an interface data type, and assign it a value that is of 
        // a type that implements that interface
        OuterClass.MyInterface mi = ic;

        // Use instanceof and casting as usual
        OuterClass.InnerClass ic2 = mi instanceof OuterClass.InnerClass ? 
                                    (OuterClass.InnerClass)mi : null;
        System.assert(ic2 != null);

        // Construct the outer type
        OuterClass o = new OuterClass();
        System.assertEquals(2, OuterClass.getInt());

        // Construct instances of abstract class children
        System.assertEquals(5, new OuterClass.ConcreteChildClass().abstractMethod());

        // Illegal - cannot construct an abstract class
        // new OuterClass.AbstractChildClass();

        // Illegal – cannot access a static method through an instance
        // o.getInt();

        // Illegal - cannot call protected method externally
        // new OuterClass.ConcreteChildClass().method2();
    }
}