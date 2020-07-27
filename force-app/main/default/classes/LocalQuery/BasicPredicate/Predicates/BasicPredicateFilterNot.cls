public class BasicPredicateFilterNot extends BasePredicate {
    protected BasePredicate condition;

    public BasicPredicateFilterNot(BasePredicate condition) {
        this.condition = condition;
    }

    public override Boolean evaluate(sObject obj) {
        return !condition.evaluate(obj);
    }
}
