trigger q8 on Opportunity (before update)
{
    List<Task> taskList = [Select WhatId from Task Where WhatId != null];
    
    for(Opportunity o : trigger.new)
    {
        for(Opportunity o2 : trigger.old)
        {
            for(Task t : taskList)
            {
                if(o.StageName != o2.StageName)
                {
                    if((o.Id == t.WhatId) && (o.StageName!='Closed Won' || o.StageName!='Closed Lost'))
                    {
                        o.addError('You can’t change the stage until any task is related to it.');
                    }
                }
            }   
        }
    }

}