public inherited sharing class AbstractPriceList {
    public List<AbstractPrice> prices = new List<AbstractPrice>();

    public static void show() {
        AbstractPriceList priceList = new AbstractPriceList();

        priceList.prices.add(new AbstractRegular());
        priceList.prices.add(new AbstractCoupon());

        priceList.showPrices();
        priceList.showPricesWithVisitor();
    }

    private void showPrices() {
        PriceVisitor visitor = new PriceVisitor();
        System.Debug('*********** Prices stored in Abstract list **************');
        for (AbstractPrice price : prices) {
            System.Debug(price.name() + ' ' + visitor.evaluate(price));
        }
    }

    private void showPricesWithVisitor() {
        PriceVisitor visitor = new PriceVisitor();        
        // Using the Visitor pattern we can store as base class and obtain the correct overload for the type
        System.Debug('*********** PriceVisitor for classes stored in Abstract list **************');
        for (AbstractPrice price : prices) {
            System.Debug(price.name() + ' ' + price.accept(visitor));
        }
    }
}
