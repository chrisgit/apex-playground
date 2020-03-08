public inherited sharing class SoqlSelectExpression implements ISoqlExpression  {
    public Set<ISoqlExpression> expressions
    {
        get;
        protected set;
    }

    public SoqlSelectExpression() {
        this.expressions = new Set<ISoqlExpression>();
    }

    public SoqlSelectExpression add(ISoqlExpression expr) {
        expressions.Add(expr);
        return this;
    }

    public void accept(ISoqlProjectionBuilder builder) {
        builder.build(this);
    }
}
