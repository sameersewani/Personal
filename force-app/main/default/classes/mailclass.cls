public class mailclass
{
    public static void main( Map<Id,Account> m)
    {
    List<Contact> clist=[SELECT LastName, MailingCity,AccountId FROM Contact where AccountID in :m.keySet()];// all the keys
    
    for(Contact c: clist)
    {
        Account a=m.get(c.AccountID);
        c.MailingCity=a.BillingCity;
        
    }
    update clist;
    }
      

}