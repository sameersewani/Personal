trigger demo on Opportunity (before insert,before  update) 
{
     if(trigger.isinsert)
     {
         
        Set<String>ids=new Set<String>();
        
        for(opportunity t:trigger.new)
        {
            
            ids.add(t.accountId);
        }
        system.debug('ids'+ids);
         
        List<opportunity> oldopportunity=[Select name from opportunity where accountId IN :ids];
        System.debug('size='+oldopportunity.size());
        //System.debug(oldopportunity);
        
        if(oldopportunity.size()>=5)
        {
            for(opportunity a:trigger.new)
            {
                a.addError('Each account has only 5 opportunities');
            }
        }
     }
}