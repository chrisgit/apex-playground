public class AccountService {
    public static Account createAccount(AccountRestDto dto) {
        Account acc = AccountRestDto.toSObject(dto);
        insert acc;
        dto.id = acc.id;
        return acc;
    }

    public static void updateAccount(AccountRestDto dto, string accountId) {
        // TODO: Add Error classes
        // Query, if not found then throw exception ... not found
        Account acc = AccountRestDto.toSObject(dto);
        acc.Id = accountId;
        update acc;
    }

    private static Account getAccountById(string accountId) {
        // Return Exception ... account does not exist;
        return [SELECT Id FROM Account WHERE Id = :accountId];
    }
}
