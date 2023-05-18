trigger Round on Lead (before insert,after update) 
{
    if(trigger.isInsert || trigger.isupdate)
    {
        ApexTask.main(trigger.new);
    }

}