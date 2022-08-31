@IsTest
public class Opportunity_to extends TestObject {

	public Opportunity_to(Account_to acc) {
		super(Opportunity.SObjectType);
		setParent(Opportunity.AccountId, acc);
	}

	public Opportunity_to() {
		this(new Account_to());
	}

	public Opportunity_to name(String value) {
		return (Opportunity_to) set(Opportunity.Name, value);
	}

	public Opportunity_to amount(Decimal value) {
		return (Opportunity_to) set(Opportunity.Amount, value);
	}

	public Opportunity_to stage(String value) {
		return (Opportunity_to) set(Opportunity.StageName, value);
	}

	public Opportunity_to closes(Integer year, Integer month) {
		return (Opportunity_to) set(Opportunity.CloseDate, Date.newInstance(year, month, 1));
	}

	public static Opportunity_to withDefaultValues() {
		return new Opportunity_to()
			.name('Opp1')
			.stage('Open')
			.closes(System.today().year()+1, 1);
    }
}