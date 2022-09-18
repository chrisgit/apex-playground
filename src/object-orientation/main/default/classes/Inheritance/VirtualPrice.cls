public with sharing virtual class VirtualPrice {
    public virtual String name() {
        return 'Virtual Price';
    }

    // Using the Visitor pattern
    public virtual String accept(PriceVisitor visitor) {
        return visitor.evaluate(this);
    }
}
