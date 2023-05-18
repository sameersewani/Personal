trigger sum on Opportunity (after update,after insert,after delete)
{
    if(trigger.isInsert || trigger.isUpdate)
    {
        sumclass.mymethod(trigger.new);
    }
     if(trigger.isDelete)
    {
        sumclass.mymethod1(trigger.old);
    }       
}