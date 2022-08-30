public inherited sharing class SoqlRelation implements ISoqlExpression  {
    public String relationName {
        get;
        protected set;
    }

    public Set<ISoqlExpression> expressions
    {
        get;
        protected set;
    }

    public SoqlRelation(String relationName) {
        if(String.isBlank(relationName)) {
            throw new ArgumentException('Soql relationship name cannot be blank');
        }
        this.relationName = relationName;
        this.expressions = new Set<ISoqlExpression>();
    }

    public SoqlRelation add(ISoqlExpression expr) {
        expressions.Add(expr);
        return this;
    }

    public void accept(ISoqlProjectionBuilder builder) {
        builder.build(this);
    }
}
