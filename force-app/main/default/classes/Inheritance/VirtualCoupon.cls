public with sharing class VirtualCoupon extends VirtualPrice {
    public override String name() {
        return 'Virtual Coupon';
    }

    public override String accept(PriceVisitor visitor) {
        return visitor.evaluate(this);
    }
}
