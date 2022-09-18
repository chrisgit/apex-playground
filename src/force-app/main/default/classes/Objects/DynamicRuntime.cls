public with sharing class DynamicRuntime {
    public static void objectType() {
        Object value = 'Hello World';

        StaticLogger.debug('Is [{0}] a string? [{1}]', value, value instanceOf String);
    }
}
