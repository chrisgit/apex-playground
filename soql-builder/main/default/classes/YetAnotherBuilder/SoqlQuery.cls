// No special powers, could be a SelectExpression ...
 public inherited sharing class SoqlQuery {
    public SoqlSelectExpression projection {
        get;
        protected set;
    }

    public String fromObject {
        get;
        protected set;
    }

    public SoqlQuery(String objectName) {
        this.fromObject = objectName;
        this.projection = new SoqlSelectExpression();
    }

    public SoqlQuery selectFields(ISoqlExpression expr) {
        projection.Add(expr);
        return this;
    }
}
