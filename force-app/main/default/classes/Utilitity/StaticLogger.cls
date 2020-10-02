public inherited sharing class StaticLogger {

    public static void debug(Object objectInstance) {
        logDebugMessage(objectInstance);
    }

    public static void debug(String message) {
        logDebugMessage(message, new String[] {});
    }

    public static void debug(String message, Object valueOne) {
        logDebugMessage(message, new String[] { 
            String.valueOf(valueOne)
         });    
    }

    public static void debug(String message, Object valueOne, Object valueTwo) {
        logDebugMessage(message, new String[] { 
            String.valueOf(valueOne), 
            String.valueOf(valueTwo)
         });
    }

    public static void debug(String message, Object valueOne, Object valueTwo, Object valueThree) {
        logDebugMessage(message, new String[] { 
            String.valueOf(valueOne), 
            String.valueOf(valueTwo),
            String.valueOf(valueThree)
         });
    }

    private static void logDebugMessage(Object ObjectInstance) {
        System.Debug(LoggingLevel.DEBUG, objectInstance);
    }

    private static void logDebugMessage(String message, String[] parameters) {
        System.Debug(LoggingLevel.DEBUG, String.format(message, parameters));
    }
}
