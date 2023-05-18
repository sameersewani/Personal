trigger OpportunnityCurrency on Opportunity (after insert)
{
         Id i ;
        for(Opportunity o : trigger.new)
        {
            i = o.Id;
            opportunityApi.OppConvertCurrency(i);
        }
    
}