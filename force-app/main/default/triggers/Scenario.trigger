trigger Scenario on OpportunityLineItem (before insert) 
{
  	Decimal price=0;
    List<opportunity> opp =new List<Opportunity>();
	for(OpportunityLineItem oli : trigger.new)
    {
        price=oli.unitPrice*oli.Quantity;
        opportunity o = new opportunity(Id=oli.OpportunityId,Amount_In_Inr__c=price);
		opp.add(o);
    }
    update opp;
    
    
    
}