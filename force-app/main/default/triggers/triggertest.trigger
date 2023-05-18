trigger triggertest on OpportunityLineItem (before insert, after delete)
{
    List<ID> OliIds = new List<ID>();// opportunity id
    List<ID> OliIds1 = new List<ID>();// opportunity id
    
     if(trigger.isInsert)
    {
        for(OpportunityLineItem o : trigger.new)
        {
            OliIds.add(o.OpportunityId); // opportunity       
        }
        triggertest.q1(OliIds,trigger.new);// opportunity id and new oppline item
    }
    
    
    
    
     
    

    if(trigger.isDelete)
    {
        for(OpportunityLineItem o1 : trigger.old)
        {
            OliIds1.add(o1.OpportunityId); // opportunity       
        }
        triggertest.q2(OliIds1,trigger.old);
    }
}