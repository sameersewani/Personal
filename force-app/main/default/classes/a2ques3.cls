public class a2ques3 
{
    public static void main()
    {
        
        list<Account>l1= [select name,(Select name from Opportunities),(Select name from contacts),
                          (select title,body from notes) from Account where Name like 'B%' ];
        
        for(Account a:l1)
        {
        
              System.debug(a);
              System.debug(a.Opportunities);
              System.debug(a.Contacts);
              System.debug(a.notes);             /* System.debug('Account Name:'+a.Name);
                                               for(Opportunity o : a.Opportunities)
                                               {
                                                   System.debug('Opportunity Name :'+o.Name);
                                               }
                                               for(Contact c : a.Contacts)
                                               {
                                                  System.debug('Contact Name:'+c.Name);
                                               }*/
        }
    }
}