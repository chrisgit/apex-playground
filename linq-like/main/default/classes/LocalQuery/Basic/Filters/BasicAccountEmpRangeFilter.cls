// File name truncated from BasicAccountEmployeeRangeFilter
public with sharing class BasicAccountEmpRangeFilter  implements IBasicAccountFilter {
    private Integer minimumEmployees;
    private Integer maximumEmployees;

    public BasicAccountEmpRangeFilter(Integer minimumEmployees, Integer maximumEmployees) {
        this.minimumEmployees = minimumEmployees;
        this.maximumEmployees = maximumEmployees;
    }

    public List<Account> filter(List<Account> accounts) {
        List<Account> employeeRangeAccounts = new List<Account>();

        for (Account account : accounts) {
            if (account.NumberOfEmployees >= this.minimumEmployees && account.NumberOfEmployees <= this.maximumEmployees ) {
                employeeRangeAccounts.add(account);
            }
        }

        return employeeRangeAccounts;
    }
}
