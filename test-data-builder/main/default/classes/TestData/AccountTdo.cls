@IsTest
public class AccountTdo extends TestDataObject {
	private Account accountReference;

	public AccountTdo() {
		super(Account.SObjectType);
		accountReference = new Account();
		name('Acme Corp');
	}

    public override SObject getRecord() {
        return this.accountReference;
    }

	public AccountTdo name(String value) {
		this.accountReference.Name = value;
		return this;
	}

	public AccountTdo opportunity(OpportunityTdo opp) {
		opp.setParent(Opportunity.AccountId, this);
		return (AccountTdo) this;
	}

	public AccountTdo contact(ContactTdo cnt) {
		cnt.setParent(Contact.AccountId, this);
		return (AccountTdo) this;
	}

    public static AccountTdo withDefaultValues() {
        return new AccountTdo()
            .name('Default Account');
    }	
}