trigger Lead on Lead (after insert)
{
    /*List<Id> idLead = new List<Id>();
   for(Lead l : trigger.new)
    {
        idLead.add(l.Id);
    }*/
    LeadConvert lc= new LeadConvert(trigger.new);
    Database.executeBatch(lc);
     //LeadConvert1.main(idLead);
     
}