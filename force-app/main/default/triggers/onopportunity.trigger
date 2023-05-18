trigger onopportunity on Opportunity (before insert, before update) 
{
    
    
     if(trigger.isbefore)
    {
        if(trigger.isinsert)
        {
            
        //checkopportunity.main(trigger.new);
          
            
        }
    }
  
    
     if(trigger.isbefore)
     {
        if(trigger.isupdate)
        {
            
        //checkopportunity.upd(trigger.old,trigger.new);
            
        }
    }

}