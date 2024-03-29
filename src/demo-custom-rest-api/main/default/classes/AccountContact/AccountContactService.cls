@SuppressWarnings('PMD.ApexSharingViolations')
public class AccountContactService {
    public static Id createAccountAndContacts(AccountRestDto dto) {
        validateCreateRequest(dto);

        Savepoint sp = Database.setSavepoint();
        try {
            Account acc = createAccount(dto);
            createContacts(dto, acc);
            return acc.Id;
        } catch (Exception exc) {
            Database.rollback(sp);
            throw exc;
        }
    }

    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static void updateAccount(AccountRestDto dto, string accountId) {
        validateUpdateRequest(dto);

        Savepoint sp = Database.setSavepoint();
        try {
            Account acc = AccountRestDtoMapper.toAccountSObject(dto);
            acc.Id = accountId;
            update acc;
        } catch (Exception exc) {
            Database.rollback(sp);
            throw exc;            
        }
    }

    public static void deleteAccountAndContacts(string accountId) {
        Savepoint sp = Database.setSavepoint();
        try {
            delete [SELECT Id FROM Contact WHERE AccountId = :accountId];
            delete [SELECT Id FROM Account WHERE Id = :accountId];
        } catch (Exception exc) {
            Database.rollback(sp);
            throw exc;            
        }        
    }

    @SuppressWarnings('PMD.ApexCRUDViolation')
    private static Account createAccount(AccountRestDto dto) {
        Account acc = AccountRestDtoMapper.toAccountSObject(dto);
        insert acc;
        return acc;
    }

    @SuppressWarnings('PMD.ApexCRUDViolation')
    private static void createContacts(AccountRestDto dto, Account acc) {
        if (dto.hasContacts() == false) {
            return;
        }

        List<Contact> contacts = AccountRestDtoMapper.toContactSObject(dto);
        for (Contact cnt : contacts) {
            cnt.AccountId = acc.Id;
        }

        insert contacts;
    }

    private static void validateCreateRequest(AccountRestDto dto) {
        if (dto.hasAccountId()) {
            InvalidRequestException.raise('Create Account and Contacts. Unexpected field AccountId');
        }
    }

    private static void validateUpdateRequest(AccountRestDto dto) {
        if (dto.hasAccountId()) {
            InvalidRequestException.raise('Update Account. Unexpected field AccountId');          
        }
        if (dto.hasContacts() == true) {
            InvalidRequestException.raise('Update Account. Unexpected list of contacts, please supply account only');
        }
    }
}
