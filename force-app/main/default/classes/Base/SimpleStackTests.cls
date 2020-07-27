@IsTest
public inherited sharing class SimpleStackTests {
    @IsTest
    public static void whenStackEmptyThenSizeIsZero() {
        System.assertEquals(0, new SimpleStack().size(), 'New stack size is not zero');
    }

    @IsTest
    public static void whenIsEmptyOnNewStackThenReturnTrue() {
        System.assert(new SimpleStack().isEmpty(), 'New stack size empty is not correct');
    }

    @IsTest
    public static void whenPeekEmptyStackThenThrowsException() {
        Boolean exceptionThrown = false;

        try {
            SimpleStack stack = new SimpleStack();
            stack.peek();
        } catch (InvalidOperationException ex) {
            exceptionThrown = true;
        }

        System.assertEquals(true, exceptionThrown, 'Exception was not thrown when peek on empty stack');
    }

    @IsTest
    public static void whenPopEmptyStackThenThrowsException() {
        Boolean exceptionThrown = false;

        try {
            SimpleStack stack = new SimpleStack();
            stack.pop();
        } catch (InvalidOperationException ex) {
            exceptionThrown = true;
        }

        System.assertEquals(true, exceptionThrown, 'Exception was not thrown when peek on empty stack');
    }

    @IsTest
    public static void whenPushAndPopThenSizeIncreasesAndDecreases() {
        SimpleStack stack = new SimpleStack();
        stack.push('');
        stack.push('');

        System.assertEquals(2, stack.size(), 'Stack size did not grow');

        stack.pop();

        System.assertEquals(1, stack.size(), 'Stack size did not shrink');
    }
}
