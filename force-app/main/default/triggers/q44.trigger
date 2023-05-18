trigger q44 on Account (before delete)
{
    list<Opportunity> olist=[select id,accountId,StageName from opportunity];
    for(Account a :trigger.old)
    {
        for(opportunity o : olist)
        {
            if(a.id==o.Accountid)
            {
                if(o.StageName=='Closed Won' && o.StageName=='Closed Lost')
                     a.addError('You cant delete this account because it have Some Opportunity,StageName-->'+o.StageName);
               
            }
        }
    }

}