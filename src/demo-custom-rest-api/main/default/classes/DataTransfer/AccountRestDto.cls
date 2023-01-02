public with sharing class AccountRestDto {
    public string id;
    public string accountNumber;
    public string accountName;
    public string industry;
    public List<ContactRestDto> contacts;

    public static Account toSObject(AccountRestDto accDto) {
        return new Account(
            Name = accDto.AccountName,
            AccountNumber = accDto.AccountNumber,
            Industry = accDto.Industry);
    }

    public static AccountRestDto toDto(Account acc) {
        AccountRestDto accountDto = new AccountRestDto();
        accountDto.id = acc.id;
        accountDto.accountNumber = acc.AccountNumber;
        accountDto.accountName = acc.Name;
        accountDto.industry = acc.Industry;     
        return accountDto;
    }
}
