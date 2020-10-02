public with sharing class VirtualRegular extends VirtualPrice {
    public override String name() {
        return 'Virtual Regular';
    }

    public override String accept(PriceVisitor visitor) {
        return visitor.evaluate(this);
    }
}
