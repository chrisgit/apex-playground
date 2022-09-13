@IsTest
public class Contact_to extends TestObject {
    private Contact contactReference;

    public Contact_to() {
        super(Contact.SObjectType);
        contactReference = new Contact();
        defaultValues();
    }

    public override SObject getRecord() {
        return this.contactReference;
    }

    public Contact_to first(String value) {
        this.contactReference.FirstName = value;
        return this;
    }

    public Contact_to last(String value) {
        this.contactReference.LastName = value;
        return this;
    }

    public Contact_to email(String value) {
        this.contactReference.Email = value;
        return this;
    }

    public Contact_to reports(Contact_to otherContact) {
        setParent(Contact.ReportsToId, otherContact);
        return this;
    }

    public Account_to account() {
        return (Account_to)getParent(Contact.AccountId);
    }

    public Contact_to account(Account_to acc) {
        return (Contact_to)setParent(Contact.AccountId, acc);
    }

    private void defaultValues() {
        String firstname = FakerPerson.firstName();
        String lastname = FakerPerson.lastName();
        String emailAddress = String.format('{0}.{1}@{2}', new String[] { firstname, lastname, FakerEmail.address() });
        
        first(firstname).last(lastname).email(emailAddress);
    }    
}