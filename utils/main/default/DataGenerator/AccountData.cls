public with sharing class AccountData {
    public static List<Account> accounts() {
        List<Account> accounts = new List<Account> {
            new Account(Name = 'IBM', 	AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology'),
            new Account(Name = 'IBM', 	AccountNumber = 'IBM015', Site = 'Chiswick', NumberOfEmployees = 88, Industry = 'Technology'),
            new Account(Name = 'Microsoft', AccountNumber = 'MS001', Site = 'Redmond', NumberOfEmployees = 8192, Industry = 'Technology'),
            new Account(Name = 'Microsoft', AccountNumber = 'MS029', Site = 'Reading', NumberOfEmployees = 3764, Industry = 'Technology'),
            new Account(Name = 'Oracle', AccountNumber = 'ORA001', Site = 'San Jose', NumberOfEmployees = 4115, Industry = 'Technology'),
            new Account(Name = 'Oracle', AccountNumber = 'ORA055', Site = 'Reading', NumberOfEmployees = 1011, Industry = 'Technology'),
            new Account(Name = 'Homebase', AccountNumber = 'HOME001', Site = 'Basingstoke', NumberOfEmployees = 56, Industry = 'Retail'),
            new Account(Name = 'Homebase', AccountNumber = 'HOME014', Site = 'Southampton', NumberOfEmployees = 94, Industry = 'Retail'),
            new Account(Name = 'Homebase', AccountNumber = 'HOME029', Site = 'Northampton', NumberOfEmployees = 68, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG001', Site = 'Holburn', NumberOfEmployees = 16, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG099', Site = 'Newbury', NumberOfEmployees = 12, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG103', Site = 'Basingstoke', NumberOfEmployees = 14, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG107', Site = 'Plymouth', NumberOfEmployees = 22, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG109', Site = 'Southampton', NumberOfEmployees = 26, Industry = 'Retail'),
            new Account(Name = 'Argos', AccountNumber = 'ARG110', Site = 'Southsea', NumberOfEmployees = 23, Industry = 'Retail'),
            new Account(Name = 'Debenhams', AccountNumber = 'DEB012', Site = 'Holburn', NumberOfEmployees = 350, Industry = 'Retail')
        };

        return accounts;
    }
}

/*
List<Account> accounts = AccountData.accounts();
List<Object> objects = new List<Object>();
// List<Object> objects = new List<Object>(accounts); // Not possible
// List<Object> objects = accounts; // Allowed but must still cast
objects.add(accounts.get(0));
Object oAcc = objects.get(0);
Account acc = (Account)oAcc;
Account anotherAcc = oAcc; // Must cast
System.Debug(oAcc);
System.Debug(acc);

// Cast List<Account> -> List<Object> -> List<Account>
public class PassingLists {

    public static void callWithAccountList() {
		List<Account> accounts = new List<Account>(); // AccountData.accounts();
		List<Account> dup = (List<Account>)pickThreeItems(accounts);
        System.Debug(dup);
    }
    
    public static List<Object> pickThreeItems(List<Object> acc) {
        // acc.clone();
        acc.add(new Account(Name = 'IBM', 	AccountNumber = 'IBM001', Site = 'Uxbridge', NumberOfEmployees = 120, Industry = 'Technology'));
        acc.add(new Account(Name = 'IBM', 	AccountNumber = 'IBM015', Site = 'Chiswick', NumberOfEmployees = 88, Industry = 'Technology'));

        return acc;
    }
    
    public static void example() {
		PassingLists.callWithAccountList();        
    }
}

// Update multiple sObjects with a single DML: https://developer.salesforce.com/forums/?id=906F0000000AzDeIAK
List<Account> accountList = new List<Account>();
List<Contact> contactList = new List<Contact>();

for (Integer i = 0; i < 10; i++) {
	accountList.add(new Account(Name = 'Boards Test Accout ' + i));
	contactList.add(new Contact(
            FirstName = 'Boards ' + i,
            LastName = 'Test Contact'
    ));
}

List<sObject> objects = new List<sObject>();
objects.addAll((List<sObject>)(accountList));
objects.addAll((List<sObject>)(contactList));
   
insert objects;

*/
