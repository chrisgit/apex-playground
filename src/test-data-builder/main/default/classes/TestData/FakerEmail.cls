//@IsTest
public with sharing class FakerEmail {
    private static List<String> tld = new List<String> { 'com', 'biz', 'info', 'net', 'org', 'co.uk' };
    private static List<String> popularFreeEmail = new List<String> { 'gmail', 'yahoo', 'hotmail' };

    public static String address() {
        return string.format('{0}.{1}', new String[] {
            popularFreeEmail[rnd(popularFreeEmail.size() -1)],
            tld[rnd(tld.size() - 1)]});
    }

    private static Integer rnd(Integer maximum) {
        return Integer.valueof((Math.random() * maximum));
    }
}
