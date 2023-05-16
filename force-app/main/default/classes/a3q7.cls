public class a3q7 
{
    public static void main()
    {
       list<Account> acclist=new list<Account>();
        for(integer i=1;i<=5; i++)
        {
            Account a= new Account(name='Account' +i);
            acclist.add(a);
        }
        
        Database.SaveResult[] savelist= Database.insert(acclist,false);
        
          for( Database.SaveResult s: savelist)
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
        List<Contact> contList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
         Date d = Date.today()+30;
        for(Account a:accList)
        {
            Contact c = new Contact(lastname = a.name+'contact',AccountId = a.id);
            contList.add(c);
            Opportunity o = new Opportunity(name = a.name+'Opprtunity', stageName = 'Qualification',closeDate = d, AccountId = a.id );
            oppList.add(o);
        }
        insert contList;
        insert oppList;
        
        
        
        
   
    }

}