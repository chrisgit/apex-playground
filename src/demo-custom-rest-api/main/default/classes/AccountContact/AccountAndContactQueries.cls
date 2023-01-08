public with sharing class AccountAndContactQueries {
    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getAllAccountsWithContacts() {
        List<Account> accounts = [
            SELECT Id, Name, AccountNumber, Industry, 
                (SELECT Id, FirstName, LastName, HomePhone, MobilePhone, Email
                FROM Contacts) 
            FROM Account
            LIMIT 100];
        return accounts;
    }

    @SuppressWarnings('PMD.ApexCRUDViolation')
    public static List<Account> getAccountByIdWithContacts(Id accountId) {
        List<Account> accounts = [
            SELECT Id, Name, AccountNumber, Industry, 
                (SELECT Id, FirstName, LastName, HomePhone, MobilePhone, Email
                FROM Contacts) 
            FROM Account
            WHERE Id = :accountId
            LIMIT 1];
        return accounts;
    }
}
