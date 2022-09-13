@IsTest
public class Account_to extends TestObject {
	private Account accountReference;

	public Account_to() {
		super(Account.SObjectType);
		accountReference = new Account();
		name('Acme Corp');
	}

    public override SObject getRecord() {
        return this.accountReference;
    }

	public Account_to name(String value) {
		this.accountReference.Name = value;
		return this;
	}

	public Account_to opportunity(Opportunity_to opp) {
		opp.setParent(Opportunity.AccountId, this);
		return (Account_to) this;
	}

	public Account_to contact(Contact_to cnt) {
		cnt.setParent(Contact.AccountId, this);
		return (Account_to) this;
	}

    public static Account_to withDefaultValues() {
        return new Account_to()
            .name('Default Account');
    }	
}