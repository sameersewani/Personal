trigger Payment on Payment__c (after insert)
{
    
    list<Payment__c> pp= trigger.new;
    String oppid;
    Decimal amt=0;
    for(Payment__c p:pp)
    {
        oppid=p.Opportunity__c;
    }
    
    list<Payment__c> pay=[select name,Opportunity__c,AmountPaid__c from Payment__c where Opportunity__c=:oppid];
    for(Payment__c p:pay)
    {
        amt+=p.AmountPaid__c;
    }
    system.debug('amount paid'+amt);
    
    List<Opportunity> opp=[select id,name,amount,DueAmount__c from opportunity where id=:oppid];
    
    for(opportunity o:opp)
    {
        o.DueAmount__c=o.amount-amt;
        system.debug('id'+o.Id);
        system.debug('amount  '+o.amount);
      system.debug('Due amount  '+o.DueAmount__c);
    }
    Update opp;
    
    

}