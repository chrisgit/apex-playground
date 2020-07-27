public class BasicPredicateFilterRange extends BasePredicate {
    protected Object startRange;
    protected Object endRange;

    public BasicPredicateFilterRange(Schema.SObjectField field, Object startRange, Object endRange) {
        super(field, null);
        this.startRange = startRange;
        this.endRange = endRange;
    }

    public override Boolean evaluate(sObject obj) {
        // return obj.get(this.schemaField) >= this.startRange && obj.get(this.schemaField) <= this.endRange;
        Object value = obj.get(this.schemaField);
        // Integer compareStart = ObjectInstance.compare(value, this.startRange);
        // Integer compareEnd = ObjectInstance.compare(value, this.endRange);

        // return compareStart >= 0 && compareEnd <= 0;

        return valueGreaterThanEqualToStart(value, this.startRange) && valueLessThanOrEqualToEnd(value, this.endRange);
        // if (value instanceOf Decimal) {
        //     return compare((Decimal)value, (Decimal)this.startRange, (Decimal)this.endRange);
        // }
        // return false;
    }

    private Boolean valueGreaterThanEqualToStart(Object value, Object startRange) {
        return ObjectInstance.compare(value, startRange) >= 0;
    }

    private Boolean valueLessThanOrEqualToEnd(Object value, Object startRange) {
        return ObjectInstance.compare(value, endRange) <= 0;
    }

    // // Make this a strategy? ...
    // private Boolean compare(Decimal value, Decimal startRange, Decimal endRange) {
    //     return value >= startRange && value <= endRange;
    // }

    // // Make this a general helper or whatever
    // public static string getType(Object o) {
    //     if(o==null) return '';              // we can't say much about null with our current techniques
    //     if(o instanceof SObject)            return ((SObject)o).getSObjectType().getDescribe().getName()+''; 
    //     if(o instanceof Boolean)            return 'Boolean';
    //     if(o instanceof Id)                 return 'Id';
    //     if(o instanceof String)             return 'String';
    //     if(o instanceof Blob)               return 'Blob';
    //     if(o instanceof Date)               return 'Date';
    //     if(o instanceof Datetime)           return 'Datetime';
    //     if(o instanceof Time)               return 'Time';
    //     if(o instanceof String)             return 'String';
    //     if(o instanceof Integer)            return 'Integer';
    //     if(o instanceof Long)               return 'Long';
    //     if(o instanceof Decimal)            return 'Decimal';  // we can't distinguish between decimal and double
    //     if(o instanceof Double)             return 'Double';   // we can't distinguish between decimal and double
    //     if(o instanceof List<object>)       return 'List';
    //     return 'Object';                    // actually we can't detect maps and sets and maps
    // }    
}
