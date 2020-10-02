public inherited sharing class AbstractCoupon extends AbstractPrice implements IPromotion {
    public override String name() { 
        return 'Coupon Price';
    }

    public String promotion() {
        return 'Promotion - Coupon Price';
    }

    // Method only available in this class
    public Integer discountPercentage() {
        return 20;
    }

    // Something for free?
    public override String accept(PriceVisitor visitor)
    {
        return visitor.evaluate(this);
    }
}
