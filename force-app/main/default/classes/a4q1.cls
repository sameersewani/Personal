public class a4q1 
{
    public static void main(list <Account> acclist)
    {
        list<Opportunity> oppList = new List<Opportunity>();
        for(Account acc:accList)
        {
            if(acc.Opportunity_Count__c == 0)
            { 
                Opportunity o = new Opportunity(name = 'First Opportunity '+acc.name, accountId = acc.Id, 
                                stageName = 'Perception Analysis', closeDate = system.today() );
                oppList.add(o);
            }
        }
        insert oppList;
        
    }

}