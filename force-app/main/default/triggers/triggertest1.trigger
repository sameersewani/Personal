trigger triggertest1 on Account (after update) 
{
       for(Account accNew : Trigger.new)
       {
            for(Account accOld : Trigger.Old)
            {
                if(accNew.Id == accOld.Id && accNew.OwnerId  != accOld.OwnerId )
                {
                    test1.sendMailOnUpdate(accNew.Id, accOld.OwnerId, accNew.OwnerId);
                }
            }
        }


}