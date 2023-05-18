trigger q1 on Account (before insert)
{   
    
/*list<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:Trigger.new)
        {
            if(acc.Opportunity_Count__c == 0)
            { 
                Opportunity o = new Opportunity(name = 'First Opportunity '+acc.name, accountId = acc.Id, 
                                stageName = 'Perception Analysis', closeDate = system.today() );
                oppList.add(o);
            }
        }
        insert oppList;
*/
    list<Account> ac = new list<Account>();
        for(Account acc : trigger.new)
        {
            acc.NumberOfEmployees=20;
            ac.add(acc);
        }    
           //update ac;
        system.debug(ac);
    
}