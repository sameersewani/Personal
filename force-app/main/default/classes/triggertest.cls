public class triggertest 
{
	public static void q1(List<ID> oliIDs , List<OpportunityLineItem> ol)
    {
        List<Opportunity> olist = [Select Id, Name,LineCount__c from Opportunity where id IN : oliIDS];
        for(opportunity opp : olist)
        {
            for(OpportunityLineItem oli : ol)
            { 
                if(opp.id==oli.OpportunityId)
                {  
                    if(opp.LineCount__c==null)
                    {
                        opp.LineCount__c=0;
                    }
                    oli.Count__c=opp.LineCount__c+1;
                    opp.LineCount__c++;
                }
            }
        }
        update olist;

    } 
    
    
    
    public static void q2(List<ID> oliIDs1 , List<OpportunityLineItem> ol)
    {
        List<Opportunity> olist = [Select Id, Name,LineCount__c from Opportunity where id IN : oliIDS1];
        for(opportunity opp : olist)
        {
            for(OpportunityLineItem oli : ol)
            { 
                 if(opp.id==oli.OpportunityId)
                 {
                      opp.LineCount__c--;
                 }
                
            }
        }
        update olist;
        
    }
}