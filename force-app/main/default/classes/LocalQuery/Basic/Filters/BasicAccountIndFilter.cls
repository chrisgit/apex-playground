// File name truncated, was BasicAccountSectorFilter
public inherited sharing class BasicAccountIndFilter implements IBasicAccountFilter {
   private String sector;
 
   public BasicAccountIndFilter(String sector) {
      this.sector = sector;
   }

   public List<Account> filter(List<Account> accounts) {
      List<Account> accountsForSector = new List<Account>();

      for (Account account : accounts) {
         if (account.Industry == this.sector) {
            accountsForSector.add(account);
         }
      }

      return accountsForSector;
   }
}
