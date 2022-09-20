public class BasicPredicateFilterAnd extends BasePredicate {
    BasePredicate conditionOne;
    BasePredicate conditionTwo;
    public BasicPredicateFilterAnd(BasePredicate conditionOne, BasePredicate conditionTwo) {
        this.conditionOne = conditionOne;
        this.conditionTwo = conditionTwo;
    }

    public override Boolean evaluate(sObject obj) {
        return conditionOne.evaluate(obj) && conditionTwo.evaluate(obj);
    }
}