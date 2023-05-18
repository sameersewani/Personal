trigger StripeDapp on Transactionn__c (after insert) 
{
     
            for(Transactionn__c tr : trigger.new)
                {
                    Integer amt=Integer.valueOf(tr.AmountPaid__c);// transaction amount
                    Id oppid=tr.OpportunityId__c;
                        
                    Opportunity opp=[select Id,amount,name from opportunity  where id=:oppid];
                    Integer oppamt=Integer.valueOf(opp.Amount);// opportunity amount
                    String name=opp.Name;// opportunity Name
                    
                    if(amt>opp.Amount)
                    {
                        tr.addError('you cant make payment');
                    }
                    else if(amt<=opp.Amount)
                    {
                        if(System.IsBatch() == false && System.isFuture() == false)
                        { 
                             StripeQue.payment(amt,oppamt,opp.Id,name,tr.Id);
                         }
                       
                    }
                    
                }
}