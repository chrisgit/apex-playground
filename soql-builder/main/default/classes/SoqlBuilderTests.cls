@IsTest
public class SoqlBuilderTests {
    @IsTest
    public static void Given_SoqlQuery_When_BuiltWithLogicBuilder_Then_ReturnsValidSoqlStatement() {
        SoqlQuery query = new SoqlQuery('Opportunity');
        query.projection
            .add(new SoqlField('Name'))
            .add(new SoqlField('LeadSource'))            
            .add(new SoqlField('CloseDate'))
			.add(new SoqlRelation('Account').add(new SoqlField('Name')));

        // This builder validates the fields
        ISoqlProjectionBuilder builder = new SoqlProjectionBuilderWithLogic();
        builder.build(query);

        System.assertEquals('SELECT Name, LeadSource, CloseDate, Account.Name FROM Opportunity', builder.toString());
    }

    @IsTest
    public static void Given_SoqlQuery_When_BuiltWithBasicBuilder_Then_ReturnsSoqlStatement() {
        SoqlQuery query = new SoqlQuery('Opportunity');
        query.projection
            .add(new SoqlField('Name'))
            .add(new SoqlField('SomeFieldThatDoesNotExist'))
            .add(new SoqlRelation('Account').add(new SoqlField('Name')));

        // This builder does not perform any validation, merely outputs what it is given
        ISoqlProjectionBuilder builder = new SoqlProjectionBuilder();
        builder.build(query);

        System.assertEquals('SELECT Name, SomeFieldThatDoesNotExist, Account.Name FROM Opportunity', builder.toString());
    }
}
