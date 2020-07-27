public with sharing abstract class OopAbstractBase {
    public abstract String showClass();

    // Cannot declare and use abstract method with content
    // Also cannot use virtual and expect to work for inherited
    // public virtual String accept(OopClass_Examples examples)
    // {
    //     return examples.evaluate(this);
    // }    

    public abstract String accept(OopClassExamples examples);
}
