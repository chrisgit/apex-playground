@IsTest
public class Account_to extends TestObject {

	public Account_to() {
		super(Account.SObjectType);
		
		name('Acme Corp');
	}

    public Account_to(Integer howMany) {
        this();
    }

	public Account_to name(String value) {
		return (Account_to) set(Account.Name, value);
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