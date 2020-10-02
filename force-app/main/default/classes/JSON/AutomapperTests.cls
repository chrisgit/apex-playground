@IsTest
public with sharing class AutomapperTests {
    @IsTest
    public static void whenMappingSingleObjectToDTO() {
        Map<String, String> fieldMap = new Map<String, String> {
            'accountName' => 'Name',
            'accountNumber' => 'AccountNumber',
            'location' => 'Site',
            'employeeCount' => 'NumberOfEmployees',
            'industry' => 'Industry'
        };
        Account acc = new Account(Name = 'IBM', AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology');
        Automapper mapper = new Automapper(fieldMap);

        AccountDto dto = (AccountDto)mapper.createDTOFromSObject(acc, AccountDto.class);

        System.assertEquals(acc.Name, dto.accountName, 'Automapper: Single Object Account Name not mapped');
        System.assertEquals(acc.AccountNumber, dto.accountNumber, 'Automapper: Single Object Account Number not mapped');
        System.assertEquals(acc.Site, dto.location, 'Automapper: Single Object Account Site not mapped');
        System.assertEquals(acc.NumberOfEmployees, dto.employeeCount, 'Automapper: Single Object Account Employee Count not mapped');
        System.assertEquals(acc.Industry, dto.industry, 'Automapper: Single Object Account Industry not mapped');
    }

    // Have to flip this on it's head ... mapper for Contact, then Contact / Account, therefore ContactAccountDto
    @IsTest
    public static void whenMappingRelatedObjectToDTO() {
        Map<String, String> fieldMap = new Map<String, String> {
            'firstname' => 'FirstName',
            'lastname' => 'LastName',
            'email' => 'Email',
            'account.accountName' => 'Account.Name',
            'account.accountNumber' => 'Account.AccountNumber',
            'account.location' => 'Account.Site',
            'account.employeeCount' => 'Account.NumberOfEmployees',
            'account.industry' => 'Account.Industry'
        };
        Contact cnt = new Contact(FirstName = 'Tony', LastName = 'Stark', Email = 't.stark@avengers.com');
        cnt.Account = new Account(Name = 'IBM', AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology');
        Automapper mapper = new Automapper(fieldMap);

        ContactDto dto = (ContactDto)mapper.createDTOFromSObject(cnt, ContactDto.class);

        System.assertEquals(cnt.FirstName, dto.firstname, 'Automapper: Related Object Contact FirstName not mapped');
        System.assertEquals(cnt.LastName, dto.lastname, 'Automapper: Related Object Contact LastName not mapped');
        System.assertEquals(cnt.Email, dto.email, 'Automapper: Related Object Contact Email not mapped');
        System.assertEquals(cnt.Account.Name, dto.account.accountName, 'Automapper: Related Object Account Name not mapped');
        System.assertEquals(cnt.Account.AccountNumber, dto.account.accountNumber, 'Automapper: Related Object Account Number not mapped');
        System.assertEquals(cnt.Account.Site, dto.account.location, 'Automapper: Related Object Account Site not mapped');
        System.assertEquals(cnt.Account.NumberOfEmployees, dto.account.employeeCount, 'Automapper: Related Object Account Employee Count not mapped');
        System.assertEquals(cnt.Account.Industry, dto.account.industry, 'Automapper: Related Object Account Industry not mapped');
    }
}
