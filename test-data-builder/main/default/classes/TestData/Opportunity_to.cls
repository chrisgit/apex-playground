@IsTest
public class Opportunity_to extends TestObject {
	private Opportunity opportunityReference;

	// Optional create a hierarchy for data integrity
	// public Opportunity_to() {
	// 	this(new Account_to());
	// }
	//
	// 	public Opportunity_to(Account_to acc) {

	// TODO: Tidy up and test
	public Opportunity_to() {
		super(Opportunity.SObjectType);
		opportunityReference = new Opportunity();
		
		name('Opp1').stage('Open').closes(System.today().year()+1, 1);
	}

	// Change to property, use dynamic, i.e. Type.new?
	public override SObject getRecord() {
        return this.opportunityReference;
    }

	public Opportunity_to name(String value) {
		this.opportunityReference.Name = value;
		return this;
	}

	public Opportunity_to amount(Decimal value) {
		this.opportunityReference.Amount = value;
		return this;
	}

	public Opportunity_to stage(String value) {
		this.opportunityReference.StageName = value;
		return this;
	}

	public Opportunity_to closes(Integer year, Integer month) {
		this.opportunityReference.CloseDate = Date.newInstance(year, month, 1);
		return this;
	}

	public Account_to account() {
		return (Account_to)getParent(Opportunity.AccountId);
	}

	public Opportunity_to account(Account_to account) {
		return (Opportunity_to)setParent(Opportunity.AccountId, account);
	}
}
