trigger Stripetrigger on OpportunityLineItem (after insert)
{
            for(OpportunityLineItem ol : trigger.new)
                
                {
                    String name=ol.Name;
                    id oliid=ol.Id;
                    id oppid=ol.OpportunityId;
                    Integer qnt=Integer.valueOf(ol.Quantity);
                    
                    Opportunity o=[select name,stageName,Emai__c from opportunity where id=:oppid];
                    
                    if(o.stageName=='Closed Won')
                    {
                        Stripe.payment(oliid,name,ol.UnitPrice,o.Name,o.Emai__c,qnt);
                    }
                }
}