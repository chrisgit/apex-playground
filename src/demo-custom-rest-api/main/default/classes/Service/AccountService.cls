public class AccountService {
    public static Account createAccount(AccountRestDto dto) {
        Account acc = new Account(Name=dto.AccountName, AccountNumber=dto.AccountNumber, Industry=dto.Industry);
        insert acc;
        dto.id = acc.id;
        return acc;
    }

    public static void updateAccount(AccountRestDto dto, string accountId) {
        // TODO: Add Error classes
        // Query, if not found then throw exception ... not found
        update new Account(Id = accountId, Name=dto.AccountName, AccountNumber=dto.AccountNumber, Industry=dto.Industry);
    }

    private static Account getAccountById(string accountId) {
        // Return Exception ... account does not exist;
        return [SELECT Id FROM Account WHERE Id = :accountId];
    }
}
