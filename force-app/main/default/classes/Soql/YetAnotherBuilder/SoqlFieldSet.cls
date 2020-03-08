// Originally inherited Expression but doesn't look like it supports double dispatch
public inherited sharing class SoqlFieldSet implements ISoqlExpression  {
    public String fieldSet
    {
        get;
        protected set;
    }

    public SoqlFieldSet(String fieldSet) {
        this.fieldSet = fieldSet;
    }

    public void accept(ISoqlProjectionBuilder builder) {
        builder.build(this);
    }
}
