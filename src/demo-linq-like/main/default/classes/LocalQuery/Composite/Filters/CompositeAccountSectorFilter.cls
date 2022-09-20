public inherited sharing class CompositeAccountSectorFilter implements ICompositeAccountFilter {
   private String sector;
 
   public CompositeAccountSectorFilter(String sector) {
      this.sector = sector;
   }

   public Boolean filter(Account account) {
         if (account.Industry == this.sector) {
            return true;
         }

      return false;
   }
}
