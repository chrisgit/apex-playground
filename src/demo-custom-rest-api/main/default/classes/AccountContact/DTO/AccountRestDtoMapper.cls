public with sharing class AccountRestDtoMapper {
    public static Account toAccountSObject(AccountRestDto dto) {
        return new Account(
            Name = dto.AccountName,
            AccountNumber = dto.AccountNumber,
            Industry = dto.Industry);
    }

    public static List<Contact> toContactSObject(AccountRestDto dto) {
        List<Contact> contacts = new List<Contact>();
        if (dto.hasContacts() == true) {
            for(ContactRestDto cntDto : dto.contacts) {
                contacts.add(new Contact(
                    FirstName = cntDto.forename,
                    LastName = cntDto.surname,
                    HomePhone = cntDto.homeNumber,
                    MobilePhone = cntDto.mobileNumber,
                    Email = cntDto.email
                ));
            }
        }
        return contacts;    
    }

    public static List<AccountRestDto> toDto(List<Account> accounts) {
        List<AccountRestDto> accountsDto = new List<AccountRestDto>();
        for(Account acc: accounts) {
            AccountRestDto accountDto = accountToDto(acc);
            accountDto.contacts = contactsToDto(acc);
            accountsDto.add(accountDto);
        }
        
        return accountsDto;
    }

    private static AccountRestDto accountToDto(Account acc) {
        System.Debug(acc);

        AccountRestDto accountDto = new AccountRestDto();
        accountDto.id = acc.id;
        accountDto.accountNumber = acc.AccountNumber;
        accountDto.accountName = acc.Name;
        accountDto.industry = acc.Industry;
        accountDto.contacts = new List<ContactRestDto>();

        return accountDto;
    }

    private static List<ContactRestDto> contactsToDto(Account acc) {
        System.Debug(acc.Contacts);
        List<ContactRestDto> contactsDto = new List<ContactRestDto>();
        if (acc.Contacts != null) {
            for (Contact cnt : acc.Contacts) {
                contactsDto.add(contactToDto(cnt));
            }
        }
        return contactsDto;
    }

    private static ContactRestDto contactToDto(Contact cnt) {
        ContactRestDto cntDto = new ContactRestDto();
        cntDto.forename = cnt.FirstName;
        cntDto.surname = cnt.LastName;
        cntDto.homeNumber = cnt.HomePhone;
        cntDto.mobileNumber = cnt.MobilePhone;
        cntDto.email = cnt.Email;
        return cntDto;
   }
}
