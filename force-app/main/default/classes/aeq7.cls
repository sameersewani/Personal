public class aeq7 
{
    public static void main()
    {
       list<Account> acclist=new list<Account>();
        for(integer i=1;i<=5; i++)
        {
            Account a= new Account(name='Account' +i);
            acclist.add(a);
        }
        
        Database.SaveResult[] save= Database.insert(acclist,false);
        
          for( Database.SaveResult s: save)
          {
            if(s.isSuccess())
            {
                System.debug('i was successfull'+s.getid());
            }
              else
            {
                System.debug('Error: ');
            }
          }
         
        
        
    }

}