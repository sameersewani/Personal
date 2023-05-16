public class sumclass 
{
    public static void mymethod(List<opportunity> opplist)
    {	
        list<account> accList = new list<account> ();// account related opportunity
        list<account> acc = [select id,name from account];
             
        for(account a:acc) 
        {
            for(opportunity opp:oppList) 
            {
                if(opp.accountid == a.id)
                    accList.add(a);
            }
        }
        
        list<account> accL = new list<account>();
        decimal sum=0;
        for(account ac:accList)
        {
            for(opportunity op:opplist)
            {
                if(op.accountid == ac.id)
                {
                    sum+=op.Amount;
                }
            }
            System.debug('Add'+sum);
            ac.sumopp__c = sum;
            accL.add(ac);
        }
       update accL;
     	
    }
    
     public static void mymethod1(List<opportunity> opplist)
     {
         list<account> accList = new list<account> ();// account related opportunity
        list<account> acc = [select id,name from account];
        list<opportunity> oppor = [select id,accountid,amount from opportunity];
             
        for(account a:acc) 
        {
            for(opportunity opp:oppList) 
            {
                if(opp.accountid == a.id)
                    accList.add(a);
            }
        }
         list<account> accL = new list<account>();
         decimal sum=0;
          for(account ac:accList)
        {
            for(opportunity op:oppor)
            {
                if(op.accountid == ac.id)
                {
                    sum-=op.Amount;	
                }
            }
            System.debug('delete'+sum);
            ac.sumopp__c = sum;
            accL.add(ac);
        }
      
     }

}