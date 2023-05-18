trigger q5 on Opportunity (after insert)
{
    list<Account> clist=[SELECT Rating,Id, CustomerPriority__c FROM Account];
    list<Account>l1=new List<Account>();
    
    for(Account a: clist)
    {
            for(Opportunity o:trigger.new)
          {
                 if(o.Amount>10000 && a.id==o.Accountid)
                 {
                   a.Rating='Hot';
                   a.CustomerPriority__c='High';
                    l1.add(a);
                 }
          }
        
    }
    update l1;
}