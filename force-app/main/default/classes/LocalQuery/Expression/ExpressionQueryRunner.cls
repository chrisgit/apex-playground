public with sharing class ExpressionQueryRunner {
    public static List<SObject> filterData(List<SObject> objects, String filterConditions) {
        BasePredicate filterPredicate = new ExpressionParser(filterConditions).parse();
        return BasicPredicateQueryRunner.filterData(objects, filterPredicate);
    }
}
