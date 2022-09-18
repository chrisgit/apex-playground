// Rather than this being Projection builder ... make this a FieldList class
// Internally the FieldList class can resolve FieldSet or Expressions

public inherited sharing class SoqlProjectionBuilderWithLogic implements ISoqlProjectionBuilder {
    protected SimpleStack stack = new SimpleStack();
    protected String output = '';

    // Class to support the builder, this will act as a context
    class ObjectReference {
        public String path
        {
            get;
            protected set;
        }

        public ObjectSchema schema
        {
            get;
            protected set;
        }

        ObjectReference(String path, ObjectSchema schema) {
            this.path = path;
            this.schema = schema;
        }
    }
    
    public void build(SoqlQuery query) {
        // Push current object to stack
        ObjectSchema schema = ObjectFactory.getSchemaForSObject(query.fromObject);
        stack.push(new ObjectReference('', schema));

        this.output = this.output + 'SELECT ';
        for (ISoqlExpression e : query.projection.expressions) {
            e.accept(this);
        }

        this.output = removeTrailingComma(this.output) + ' FROM ' + query.fromObject;
     }

    public void build(SoqlField field) {
        // Field accessibility checks or other from current object
        ObjectReference reference = (ObjectReference)this.stack.peek();
        if (reference.schema.getFieldDescription(field.FieldName).isAccessible()) {
            this.output = this.output + (reference.path + field.FieldName) + ', ';
        }
    }

    public void build(SoqlSelectExpression expr) {
        for (ISoqlExpression e : expr.expressions) {
            e.accept(this);
        }
    }

    public void build(SoqlRelation expr) {
        // Push the relation object to the stack
        ObjectSchema schema = ObjectFactory.getSchemaForSObject(expr.relationName);
        String currentPath = ((ObjectReference)this.stack.peek()).path;
        this.stack.push(new ObjectReference(currentPath + expr.relationName + '.', schema));

        for (ISoqlExpression e : expr.expressions) {
            e.accept(this);
        }

        // Remove the relation from the stack
        this.stack.pop();
    }

    public void build(SoqlFieldSet expr) {
        ObjectReference reference = (ObjectReference)this.stack.peek();
        // FieldSetPaths is a dot separated path, custom relationships will end in __r
        // You can consider the elements in the dot separated path as relationships ending with a field
        // i.e. Account.BillingAddress.Name, where Name is the field, Account is current object and BillingAddress is relation
        SoqlSelectExpression selectExpression = new SoqlSelectExpression();
        for (String fieldPath : reference.schema.getFieldSetPathsOnly(expr.fieldSet)) {
            List<string> pathElement = fieldPath.split('\\.');
            Integer numberOfElements = pathElement.Size();
            if (numberOfElements > 1) {
                // Process any relationships and descend the object graph
                for(Integer relationship = 0; relationship < numberOfElements - 1; relationship++) {
                    String relationName = pathElement[relationship];
                    selectExpression.add(new SoqlRelation(relationName));
                }
            }
            // Field is at the end of the array
            String fieldName = pathElement[numberOfElements - 1];
            selectExpression.add(new SoqlField(fieldName));
        }

        selectExpression.accept(this);
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
