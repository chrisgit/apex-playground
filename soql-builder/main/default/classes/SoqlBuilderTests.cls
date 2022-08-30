@IsTest
public class SoqlBuilderTests {
    @IsTest
    public static void Given_SoqlQuery_When_BuiltWithLogicBuilder_Then_ReturnsValidSoqlStatement() {
        SoqlQuery query = new SoqlQuery('Opportunity');
        query.projection
            .add(new SoqlField('Name'))
            .add(new SoqlField('AccountNumber'));

        ISoqlProjectionBuilder builder = new SoqlProjectionBuilderWithLogic();
        builder.build(query);

        System.assertEquals('SELECT Name, AccountNumber FROM Opportunity', builder.toString());
    }

    @IsTest
    public static void Given_SoqlQuery_When_BuiltWithBasicBuilder_Then_ReturnsSoqlStatement() {
        SoqlQuery query = new SoqlQuery('Opportunity');
        query.projection
            .add(new SoqlField('Name'))
            .add(new SoqlField('AccountNumber'))
            .add(new SoqlRelation('Account').add(new SoqlField('Name')));

        ISoqlProjectionBuilder builder = new SoqlProjectionBuilder();
        builder.build(query);

        System.assertEquals('SELECT Name, AccountNumber, Account.Name FROM Opportunity', builder.toString());
    }
}
