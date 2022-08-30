public with sharing class PriceVisitor {

    // When an appropriate overload does not exist uses the Object as fallback
    public String evaluate(Object obj) {
        return 'PriceVisitor would evaluate this class as Object';
    }

    public String evaluate(IPromotion promotion) {
        return 'PriceVisitor would evaluate this class as IPromotion';
    }

    // When an appropriate inherited class from AbstractPrice does not exist uses the AbstractPrice as fallback
    public String evaluate(AbstractPrice base) {
        return 'PriceVisitor would evaluate this class as AbstractPrice';
    }

    public String evaluate(AbstractRegular regular) {
        return 'PriceVisitor would evaluate this class as AbstractRegular';
    }

    public String evaluate(AbstractCoupon coupon) {
        return 'PriceVisitor would evaluate this class as AbstractCoupon';
    }

    // When an appropriate inherited class from VirtualPrice does not exist uses the VirtualPrice as fallback
    public String evaluate(VirtualPrice base) {
        return 'PriceVisitor would process this class as VirtualPrice';
    }

    public String evaluate(VirtualRegular regular) {
        return 'PriceVisitor would process this class as VirtualRegular';
    }

    public String evaluate(VirtualCoupon coupon) {
        return 'PriceVisitor would process this class as VirtualCoupon';
    }

    // public String evaluate(VirtualWebOffer offer) {
    //     return 'PriceVisitor would process this class as VirtualWebOffer';
    // }    
}
