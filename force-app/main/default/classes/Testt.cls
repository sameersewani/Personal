public class Testt
{
    @AuraEnabled
    public static List<Account> getaccounts()
    {
        List<Account> accList=[select name,(select name from contacts) from account limit 2];
        
        if(!accList.isEmpty())
        {
            return accList;
        }
        return null;
        
    }

}