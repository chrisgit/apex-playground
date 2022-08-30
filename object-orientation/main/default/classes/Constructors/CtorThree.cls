public inherited sharing class CtorThree extends CtorTwo {
    public CtorThree() {
        StaticLogger.debug('Declared default constructor [{0}]', 'CtorThree');
    }

    public static void create() {
        StaticLogger.debug('Start: create CtorThree');
        CtorThree instance = new CtorThree();
        StaticLogger.debug('Stop: create CtorThree');
    }
}
