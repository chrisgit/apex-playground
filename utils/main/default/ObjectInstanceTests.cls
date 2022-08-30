@IsTest
public inherited sharing class ObjectInstanceTests {
    @IsTest
    public static void whenIsStringWithStringValueReturnTrue() {
        String value = 'Hello World';

        System.assert(ObjectInstance.isString(value), 'Value is string');
    }

    @IsTest
    public static void whenIsIntegerWithIntegerValueReturnTrue() {
        Integer value = 123456;

        System.assert(ObjectInstance.isInteger(value), 'Value is integer');
    }

    @IsTest
    public static void whenIsDecimalWithDecimalValueReturnTrue() {
        Decimal value = 123456.789;

        System.assert(ObjectInstance.isDecimal(value), 'Value is decimal');
    }

    @IsTest
    public static void whenIsDateWithDateValueReturnTrue() {
        Date value = Date.newInstance(2020, 03, 20);

        System.assert(ObjectInstance.isDate(value), 'Value is date');
    }

    @IsTest
    public static void whenIsDateTimeWithDateTimeValueReturnTrue() {
        Datetime value = Datetime.newInstance(2020, 03, 20, 18, 30, 55);

        System.assert(ObjectInstance.isDatetime(value), 'Value is datetime');
    }

    @IsTest
    public static void whenIsBooleanWithBooleanValueReturnTrue() {
        Boolean value = true;

        System.assert(ObjectInstance.isBoolean(value), 'Value is boolean');
    }

    @IsTest
    public static void whenIsIDWithIDValueReturnTrue() {
        String value = 'a2K7E000001cnTNUAY';

        System.assert(ObjectInstance.isID(value), 'Value is id');
    }

    @IsTest
    public static void whenCompareLessThanReturnMinusOne() {        
        Map<Object, Object> lessThanExamples = new Map<Object, Object> {
            'A' => 'B',
            Integer.valueOf('1234') => Integer.valueOf('5678'),
            (Decimal)12345.1234 => (Decimal)12345.5678,
            Date.newInstance(2018, 10, 23) => Date.newInstance(2020, 10, 10),
            Datetime.newInstance(2018, 10, 23, 18, 35, 40) => Datetime.newInstance(2018, 10, 23, 18, 35, 45)
        };

        for (Object lhs : lessThanExamples.keySet()) {
            Object rhs = lessThanExamples.get(lhs);
            Integer result = ObjectInstance.compare(lhs, rhs);
            System.assertEquals(-1, result, 'Item ' + lhs + ' should be less than ' + rhs);
        }
    }

    @IsTest
    public static void whenCompareEqualReturnZero() {        
        Map<Object, Object> equalExamples = new Map<Object, Object> {
            'A' => 'A',
            Integer.valueOf('1234') => Integer.valueOf('1234'),
            (Decimal)12345.1234 => (Decimal)12345.1234,
            Date.newInstance(2018, 10, 23) => Date.newInstance(2018, 10, 23),
            Datetime.newInstance(2018, 10, 23, 18, 35, 40) => Datetime.newInstance(2018, 10, 23, 18, 35, 40)
        };
    
        for (Object lhs : equalExamples.keySet()) {
            Object rhs = equalExamples.get(lhs);
            Integer result = ObjectInstance.compare(lhs, rhs);
            System.assertEquals(0, result, 'Item ' + lhs + ' should be equal to ' + rhs);
        }
    }

    @IsTest
    public static void whenCompareGreaterThanReturnOne() {        
        Map<Object, Object> greaterThanExamples = new Map<Object, Object> {
            'B' => 'A',
            Integer.valueOf('5678') => Integer.valueOf('1234'),
            (Decimal)12345.5678 => (Decimal)12345.1234,
            Date.newInstance(2020, 10, 10) => Date.newInstance(2018, 10, 23),
            Datetime.newInstance(2018, 10, 23, 18, 35, 45) => Datetime.newInstance(2018, 10, 23, 18, 35, 40)
        };
    
        for (Object lhs : greaterThanExamples.keySet()) {
            Object rhs = greaterThanExamples.get(lhs);
            Integer result = ObjectInstance.compare(lhs, rhs);
            System.assertEquals(1, result, 'Item ' + lhs + ' should be greater than ' + rhs);
        }
    }
}


// Should really start to write tests for this
// Date d1 = Date.newInstance(2018, 07, 01);
// Date d2 = Date.newInstance(2018, 06, 30);
// Date d3 = Date.newInstance(2018, 07, 02);

// Object o1 = d1;
// Object o2 = d2;
// Object o3 = d3;

// // Operator not allowed for this type
// //System.Debug(o1 > o2);
// 1, -1, 0
// System.Debug(ObjectInstance.compare(o1, o2));
// System.Debug(ObjectInstance.compare(o1, o3));
// System.Debug(ObjectInstance.compare(o1, o1));