public inherited sharing class CompositeAccountEmployeeRangeFilter implements ICompositeAccountFilter {
    private Integer minimumEmployees;
    private Integer maximumEmployees;

    public CompositeAccountEmployeeRangeFilter(Integer minimumEmployees, Integer maximumEmployees) {
        this.minimumEmployees = minimumEmployees;
        this.maximumEmployees = maximumEmployees;
    }

    public Boolean filter(Account account) {
        if (account.NumberOfEmployees >= this.minimumEmployees && account.NumberOfEmployees <= this.maximumEmployees ) {
            return true;
        }

        return false;
    }
}
