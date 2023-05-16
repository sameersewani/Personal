public class a3q10 
{
    public static void main()
    {
         savepoint sp = Database.setSavepoint();
        
                list<Account> acclist= new list<Account>();
                for(integer i=1;i<=100;i++)
                {
                    Account a= new Account(Name='RollBackq');
                    acclist.add(a);
                }
                
                        Database.SaveResult[] save= Database.insert(acclist,false);
                        integer count=0;
                
                      for( Database.SaveResult s: save)
                      {
                        if(s.isSuccess())
                        {
                            System.debug('i was successfull'+s.getid());
                            count++;
                        }
                          else
                        {
                            System.debug('Error: ');
                        }
                      }
        if(count<80)
        {
            database.rollback(sp);
        }
       
       
    }
}