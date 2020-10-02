public inherited sharing abstract class AbstractPrice {
    // Abstract is not allowed on fields
    // public abstract Integer discount;
    
    public abstract String name();

    // Cannot declare and use abstract method with content
    // Also cannot use virtual and expect to work for inherited
    // public virtual String accept(PriceVisitor examples)
    // {
    //     return examples.evaluate(this);
    // }    
    public abstract String accept(PriceVisitor visitor);
}
