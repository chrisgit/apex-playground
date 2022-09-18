@IsTest
public class OpportunityTdo extends TestDataObject {
	private Opportunity opportunityReference;

	// Optional create a hierarchy for data integrity
	// public Opportunity_to() {
	// 	this(new Account_to());
	// }
	//
	// 	public Opportunity_to(Account_to acc) {

	// TODO: Tidy up and test
	public OpportunityTdo() {
		super(Opportunity.SObjectType);
		opportunityReference = new Opportunity();		
		name('Opp1').stage('Open').closes(System.today().year()+1, 1);
	}

	public override SObject getRecord() {
        return this.opportunityReference;
    }

	public OpportunityTdo name(String value) {
		this.opportunityReference.Name = value;
		return this;
	}

	public OpportunityTdo amount(Decimal value) {
		this.opportunityReference.Amount = value;
		return this;
	}

	public OpportunityTdo stage(String value) {
		this.opportunityReference.StageName = value;
		return this;
	}

	public OpportunityTdo closes(Integer year, Integer month) {
		this.opportunityReference.CloseDate = Date.newInstance(year, month, 1);
		return this;
	}

	public AccountTdo account() {
		return (AccountTdo)getParent(Opportunity.AccountId);
	}

	public OpportunityTdo account(AccountTdo account) {
		return (OpportunityTdo)setParent(Opportunity.AccountId, account);
	}
}
