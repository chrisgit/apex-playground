public with sharing class CompositeAccountRunner {
    public static List<Account> selectWhenAllFiltersPass(List<Account> accounts, List<ICompositeAccountFilter> selectConditions) {
        List<Account> selectedAccounts = new List<Account>();
        Boolean conditionResult = true;

        for (Account account : accounts) {
            conditionResult = true;
            for (ICompositeAccountFilter condition : selectConditions) {
                conditionResult = condition.filter(account);
                if (conditionResult == false) { break; }  // The variance, if any condition is false we can exit early
            }
            if (conditionResult) {
                selectedAccounts.add(account);
            }
        }

        return selectedAccounts;        
    }

    public static List<Account> selectWhenAnyFiltersPass(List<Account> accounts, List<ICompositeAccountFilter> selectConditions) {
        List<Account> selectedAccounts = new List<Account>();
        Boolean conditionResult = true;

        for (Account account : accounts) {
            conditionResult = true;
            for (ICompositeAccountFilter condition : selectConditions) {
                conditionResult = condition.filter(account);
                if (conditionResult == true) { break; }   // The variance, if any condition is true we can exit early
            }
            if (conditionResult) {
                selectedAccounts.add(account);
            }
        }

        return selectedAccounts;        
    }
}
