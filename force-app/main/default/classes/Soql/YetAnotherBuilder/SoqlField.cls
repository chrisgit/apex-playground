// Originally inherited Expression but doesn't look like it supports double dispatch
   public inherited sharing class SoqlField implements ISoqlExpression  {
    public String fieldName
    {
        get;
        protected set;
    }

    public SoqlField(String fieldName) {
        if(String.isBlank(fieldName)) {
            throw new ArgumentException('Soql field name cannot be blank');
        }
       
        this.FieldName = fieldName;
    }

    public void accept(ISoqlProjectionBuilder builder) {
        builder.build(this);
    }
}
