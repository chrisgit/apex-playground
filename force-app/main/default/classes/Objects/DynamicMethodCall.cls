public with sharing class DynamicMethodCall implements Callable {
    public String product;
    protected Decimal basePrice;
    protected Decimal discountPercentage;
    public Decimal price {
        get {
            if (this.onPromotion) {
                return promotionPrice;
            }
            return basePrice;
        }
    }
    protected Decimal promotionPrice;
    protected String promotionReason;
    protected Boolean onPromotion;

    public DynamicMethodCall(String product, Decimal price) {
        this.product = product;
        this.basePrice = price;
    }

    public void startPromotion(String promotionReason, Decimal promotionPrice) {
        this.promotionReason = promotionReason;
        this.promotionPrice = promotionPrice;
        this.onPromotion = true;
    }

    public void endPromotion() {
        this.promotionReason = '';
        this.promotionPrice = 0;
        this.onPromotion = false;
    }

    public Boolean onPromotion() {
        return onPromotion;
    }

    public string promotionReason() {
        return promotionReason;
    }

    // Callable interface method, returns Object
    public Object call(String action, Map<String, Object> args) {
        switch on action {
            when 'startPromotion' {
                this.startPromotion((String)args.get('promotionReason'), (Decimal)args.get('promotionPrice'));
            }
            when 'endPromotion' {
                this.endPromotion();
            }
            when else {
                // Ideally thrown method not found exception
                return null;
            }
        }
        return true;
    }    
}
