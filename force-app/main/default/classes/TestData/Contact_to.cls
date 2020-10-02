@IsTest
public class Contact_to extends TestObject {

    public Contact_to() {
        super(Contact.SObjectType);
    }

    public Contact_to(Account_to acc) {
        super(Contact.SObjectType);
        setParent(Contact.AccountId, acc);
    }

    public Contact_to first(String value) {
        return (Contact_to) set(Contact.FirstName, value);
    }

    public Contact_to last(String value) {
        return (Contact_to) set(Contact.LastName, value);
    }

    public Contact_to email(String value) {
        return (Contact_to) set(Contact.Email, value);
    }

    public Contact_to reports(Contact_to c) {
        setParent(Contact.ReportsToId, c);
        return (Contact_to) this;
    }

    public static Contact_to withDefaultValues() {
        String firstname = FakerPerson.firstName();
        String lastname = FakerPerson.lastName();
        String emailAddress = String.format('{0}.{1}@{2}', new String[] { firstname, lastname, FakerEmail.address() });
        
        return new Contact_to()
            .first(firstname)
            .last(lastname)
            .email(emailAddress);
    }    
}