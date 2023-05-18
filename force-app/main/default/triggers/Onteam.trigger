trigger Onteam on Team__c (before insert)
{
    
    if(trigger.isbefore)
    {
        if(trigger.isinsert)
        {
            
        Team.main(trigger.new);
            
        }
    }
  
    
   

}