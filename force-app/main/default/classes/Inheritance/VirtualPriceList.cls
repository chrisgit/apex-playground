public with sharing class VirtualPriceList {
    public List<VirtualPrice> prices = new List<VirtualPrice>();

    public static void show() {
        VirtualPriceList priceList = new VirtualPriceList();

        priceList.prices.add(new VirtualPrice());
        priceList.prices.add(new VirtualRegular());
        priceList.prices.add(new VirtualCoupon());
        priceList.prices.add(new VirtualWebOffer());

        priceList.showPrices();
        priceList.showPricesWithVisitor();
    }

    private void showPrices() {
        PriceVisitor visitor = new PriceVisitor();
        System.Debug('*********** Prices stored in Virtual list **************');
        for (VirtualPrice price : prices) {
            System.Debug(price.name() + ' ' + visitor.evaluate(price));
        }
    }

    private void showPricesWithVisitor() {
        PriceVisitor visitor = new PriceVisitor();        
        // Using the Visitor pattern we can store as base class and obtain the correct overload for the type
        System.Debug('*********** PriceVisitor for classes stored in Virtual list **************');
        for (VirtualPrice price : prices) {
            System.Debug(price.name() + ' ' + price.accept(visitor));
        }
    }
}
