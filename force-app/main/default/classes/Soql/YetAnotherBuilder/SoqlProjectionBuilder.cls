// The visitor class
// Basic implimentation, constructs string from object graph
public inherited sharing class SoqlProjectionBuilder implements ISoqlProjectionBuilder {
    protected String output = '';

    public static void example() {
        System.debug('**** Starting');
        SoqlQuery query = new SoqlQuery('Opportunity');
        query.projection
            .add(new SoqlField('Name'))
            .add(new SoqlField('AccountNumber'))
            .add(new SoqlRelation('Hello').add(new SoqlField('World')))
            .add(new SoqlRelation('Goodbye').add(new SoqlRelation('Cruel').add(new SoqlField('World'))))
            .add(new SoqlFieldSet('AccountFieldSet'));

        System.debug('**** Build the Soql');
        SoqlProjectionBuilder builder = new SoqlProjectionBuilder();
        builder.build(query);

        System.debug('**** Output: ' + builder.ToString());
    }

    public void build(SoqlQuery query) {
        this.output = this.output + 'SELECT ';
        for (ISoqlExpression e : query.projection.expressions) {
            e.accept(this);
        }
        this.output = removeTrailingComma(this.output) + ' FROM ' + query.fromObject;
     }

    public void build(SoqlField field) {
        this.output = this.output + field.FieldName + ', ';
    }

    public void build(SoqlSelectExpression expr) {
        for (ISoqlExpression e : expr.expressions) {
            e.accept(this);
        }
    }

    public void build(SoqlRelation expr) {
        for (ISoqlExpression e : expr.expressions) {
            this.output = this.output + expr.relationName + '.';
            e.accept(this);
        }
    }

    public void build(SoqlFieldSet expr) {
        output = output + expr.fieldSet + ',';
    }

    public override String ToString() {
        return output;
    }

    private String removeTrailingComma(String text) {
        if (text.endsWith(', ')) {
            return text.left(text.length() - 2);
        }
        return text;
    }
}
