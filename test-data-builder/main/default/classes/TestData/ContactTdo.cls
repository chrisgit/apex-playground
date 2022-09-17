@IsTest
public class ContactTdo extends TestDataObject {
    private Contact contactReference;

    public ContactTdo() {
        super(Contact.SObjectType);
        contactReference = new Contact();
        defaultValues();
    }

    public override SObject getRecord() {
        return this.contactReference;
    }

    public ContactTdo first(String value) {
        this.contactReference.FirstName = value;
        return this;
    }

    public ContactTdo last(String value) {
        this.contactReference.LastName = value;
        return this;
    }

    public ContactTdo email(String value) {
        this.contactReference.Email = value;
        return this;
    }

    public ContactTdo reports(ContactTdo otherContact) {
        setParent(Contact.ReportsToId, otherContact);
        return this;
    }

    public AccountTdo account() {
        return (AccountTdo)getParent(Contact.AccountId);
    }

    public ContactTdo account(AccountTdo acc) {
        return (ContactTdo)setParent(Contact.AccountId, acc);
    }

    private void defaultValues() {
        String firstname = FakerPerson.firstName();
        String lastname = FakerPerson.lastName();
        String emailAddress = String.format('{0}.{1}@{2}', new String[] { firstname, lastname, FakerEmail.address() });
        
        first(firstname).last(lastname).email(emailAddress);
    }    
}