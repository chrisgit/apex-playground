public with sharing class VirtualWebOffer extends VirtualPrice {
    public override String name() {
        return 'Virtual Web Offer';
    }

    public override String accept(PriceVisitor visitor) {
        return visitor.evaluate(this);
    }
}
