public with sharing class AbstractRegular extends AbstractPrice implements IPromotion {
    public override String name() { 
        return 'Regular Price';
    }

    public String promotion() {
        return 'Promotion - Regular Price';
    }

    public override String accept(PriceVisitor visitor)
    {
        return visitor.evaluate(this);
    }
}
