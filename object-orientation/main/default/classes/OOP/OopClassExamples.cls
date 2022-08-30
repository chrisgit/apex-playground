// https://salesforce.stackexchange.com/questions/165127/overloading-method-return-type-in-apex

public with sharing class OopClassExamples {

    public List<OopAbstractBase> abstractExpressions = new List<OopAbstractBase>();
    public List<IOopBase> interfaceExpressiones = new List<IOopBase>();
    public List<VirtualBase> virtualExpressions = new List<VirtualBase>();

    // Call in Anonymous window with OopClassExamples.showMethodOverloading();
    public static void showMethodOverloading() {
        OopClassExamples examples = new OopClassExamples();

        examples.abstractExpressions.add(new OopField());
        examples.abstractExpressions.add(new OopRelation());

        examples.interfaceExpressiones.add(new OopField());
        examples.interfaceExpressiones.add(new OopRelation());

        examples.virtualExpressions.add(new VirtualBase());
        examples.virtualExpressions.add(new VirtualField());
        examples.virtualExpressions.add(new VirtualRelation());

        System.Debug('*********** Show Method Calls When Using Base Classes **************');
        examples.showExpressions();

        System.Debug('*********** Show Method Calls When Using Actual Class (via GoF style Visitor Pattern) **************');
        examples.showExpressionsWithVisitor();
    }

    // Add visitor to Virtual and then call .visit
    private void showExpressions() {
        System.Debug('*********** Classes stored in Abstract list **************');
        for (OopAbstractBase expression : abstractExpressions) {
            System.Debug(expression.showClass() + ' ' + evaluate(expression));
        }

        System.Debug('*********** Classes stored in Interface list **************');
        for (IOopBase expression : interfaceExpressiones) {
            System.Debug(expression.showUnderlyingClass() + ' ' + evaluate(expression));
        }

        System.Debug('*********** Classes stored in Virtual list **************');
        for (VirtualBase expression : virtualExpressions) {
            System.Debug(expression.showClass() + ' ' + evaluate(expression));
        }
    }

    private void showExpressionsWithVisitor() {
        
        // Using the Visitor pattern we can store as base class and obtain the correct overload for the type
        System.Debug('*********** Visitor pattern for classes stored in Abstract list **************');
        for (OopAbstractBase expression : abstractExpressions) {
            System.Debug(expression.showClass() + ' ' + expression.accept(this));
        }

        // Using the Visitor pattern we can store as base class and obtain the correct overload for the type
        System.Debug('*********** Visitor pattern for classes stored in Virtual list **************');
        for (VirtualBase expression : virtualExpressions) {
            System.Debug(expression.showClass() + ' ' + expression.accept(this));
        }
    }

    public String evaluate(Object obj) {
        return 'would process this class as Object';
    }

    public String evaluate(IOopBase base) {
        return 'would process this class as IOopBase';
    }

    public String evaluate(OopAbstractBase base) {
        return 'would process this class as OopAbstractBase';
    }

    public String evaluate(OopField field) {
        return 'would process this class as OopField';
    }

    public String evaluate(OopRelation relation) {
        return 'would process this class as OopRelation';
    }

    public String evaluate(VirtualBase field) {
        return 'would process this class as VirtualBase';
    }

    public String evaluate(VirtualField field) {
        return 'would process this class as VirtualField';
    }

    public String evaluate(VirtualRelation relation) {
        return 'would process this class as VirtualRelation';
    }
}
