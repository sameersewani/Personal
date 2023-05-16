public class a2ques3b
{
    public static void main()
    {
        list<Opportunity>l1= [select name,Account.Name,(select Contact.name,ContactId from OpportunityContactRoles),(select title,body from notes) from Opportunity];
     
        for(Opportunity o : l1)
     {
         System.debug('opportunity Name'+o.Name);
         System.debug('Account Name:'+o.Account.Name);
        
         for(OpportunityContactRole op : o.OpportunityContactRoles)
         {
             system.debug('Contact name'+op.Contact.name);
             
         }
         
     }
    }
    

}