public with sharing class BasicPredicateFilterOr extends BasePredicate {
    BasePredicate conditionOne;
    BasePredicate conditionTwo;
    public BasicPredicateFilterOr(BasePredicate conditionOne, BasePredicate conditionTwo) {
        this.conditionOne = conditionOne;
        this.conditionTwo = conditionTwo;
    }

    public override Boolean evaluate(sObject obj) {
        return conditionOne.evaluate(obj) || conditionTwo.evaluate(obj);
    }
}
