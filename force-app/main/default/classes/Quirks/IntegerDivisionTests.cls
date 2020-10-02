@IsTest
public with sharing class IntegerDivisionTests {
    @IsTest
    public static void whenDivididingWithTwoIntegers() {
        Integer integerOneHundred = 100;
        Integer integerForty = 40;

        Object result = integerForty / integerOneHundred;

        System.AssertEquals(0, result, 'IntegerDivisionTests: Two Integers Failed'); // <=== Actual is 0.40
        System.Assert(result instanceOf Integer, 'IntegerDivisionTests: Two Integers Unexpected Type');
    }

    @IsTest
    public static void whenDividingWithTwoIntegersCastToDecimal() {
        Integer integerOneHundred = 100;
        Integer integerForty = 40;

        Object result = (Decimal)(integerForty / integerOneHundred);

        System.AssertEquals(0, result, 'IntegerDivisionTests: Two Integers Cast to Decimal Failed');
        System.Assert(result instanceOf Decimal, 'IntegerDivisionTests: Two Integers Cast to Decimal Unexpected Type');
    }

    @IsTest
    public static void whenDividingAnIntegerWithADecimal() {
        Decimal decimalOneHundred = 100.00;
        Integer integerForty = 40;

        Object result = integerForty / decimalOneHundred;

        System.AssertEquals(0.40, result, 'IntegerDivisionTests: Integer Divided By Decimal Failed');
        System.Assert(result instanceOf Decimal, 'IntegerDivisionTests: Integer Divided By Decimal Unexpected Type');
    }

    @IsTest
    public static void whenDividingADecimalWithAnInteger() {
        Integer integerOneHundred = 100;
        Decimal decimalForty = 40.00;

        Object result = decimalForty / integerOneHundred;

        System.AssertEquals(0.40, result, 'IntegerDivisionTests: Decimal Divided By Integer Failed');
        System.Assert(result instanceOf Decimal, 'IntegerDivisionTests: Decimal Divided By Integer Unexpected Type');
    }
    
    @IsTest
    public static void whenDividingWithTwoDecimals() {
        Decimal decimalOneHundred = 100.00;
        Decimal decimalForty = 40.00;

        Object result = decimalForty / decimalOneHundred;

        System.AssertEquals(0.40, result, 'IntegerDivisionTests: Two Decimals Failed');
        System.Assert(result instanceOf Decimal, 'IntegerDivisionTests: Two Decimals Unexpected Type');
    }    
}
