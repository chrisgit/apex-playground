public inherited sharing class ObjectInstance {

    public static Integer compare(Object valueOne, Object valueTwo) {
        if (null == valueOne && null == valueTwo) {
            return 0;
        }
        Object referenceType = null != valueOne ? valueOne : valueTwo; 
        if (isString(referenceType)) {
            return compareStrings(valueOne, valueTwo);
        }
        if (isDate(referenceType)) {
            return compareDates(valueOne, valueTwo);
        }
        if (isDatetime(referenceType)) {
            return compareDatetimes(valueOne, valueTwo);
        }
        if (isDecimal(referenceType)) {
            return compareDecimals(valueOne, valueTwo);
        }
        if (isInteger(referenceType)) {
            return compareIntegers(valueOne, valueTwo);
        }
        throw new IncompatibleTypeException();
    }

    public static Boolean isString(Object value) {
        return value instanceof String;
    }

    public static Boolean isInteger(Object value) {
        return value instanceof Integer;
    }

    public static Boolean isDecimal(Object value) {
        return value instanceof Decimal;
    }

    public static Boolean isDate(Object value) {
        return value instanceof Date;
    }

    public static Boolean isDatetime(Object value) {
        return value instanceof Datetime;
    }

    public static Boolean isBoolean(Object value) {
        return value instanceof Boolean;
    }

    public static Boolean isID(Object value) {
        return value instanceof ID;
    }

    private static Integer compareStrings(Object valueOne, Object valueTwo) {
        String lhs = String.valueOf(valueOne);
        String rhs = String.valueOf(valueTwo);

        if (lhs > rhs) {
            return 1;
        }
        if (lhs < rhs) {
            return -1;
        }
        return 0;
    }

    private static Integer compareDates(Object valueOne, Object valueTwo) {
        Date lhs = Date.valueOf(valueOne);
        Date rhs = Date.valueOf(valueTwo);

        if (lhs > rhs) {
            return 1;
        }
        if (lhs < rhs) {
            return -1;
        }
        return 0;
    }

    private static Integer compareDatetimes(Object valueOne, Object valueTwo) {
        Datetime lhs = Datetime.valueOf(valueOne);
        Datetime rhs = Datetime.valueOf(valueTwo);

        if (lhs > rhs) {
            return 1;
        }
        if (lhs < rhs) {
            return -1;
        }
        return 0;
    }

    private static Integer compareDecimals(Object valueOne, Object valueTwo) {
        Decimal lhs = (Decimal)valueOne;
        Decimal rhs = (Decimal)valueTwo;

        if (lhs > rhs) {
            return 1;
        }
        if (lhs < rhs) {
            return -1;
        }
        return 0;
    }

    private static Integer compareIntegers(Object valueOne, Object valueTwo) {
        Integer lhs = Integer.valueOf(valueOne);
        Integer rhs = Integer.valueOf(valueTwo);

        if (lhs > rhs) {
            return 1;
        }
        if (lhs < rhs) {
            return -1;
        }
        return 0;
    }
}
