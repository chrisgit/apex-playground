public interface ISoqlProjectionBuilder {
    void build(SoqlQuery query);
    void build(SoqlField field);
    void build(SoqlSelectExpression expr);
    void build(SoqlRelation expr);
    void build(SoqlFieldSet expr);
}
