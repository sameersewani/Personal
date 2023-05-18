trigger q6 on Lead (after insert)
{
   for(Lead l: trigger.new)
      {
          if (l.LeadSource=='Phone Inquiry')
            {
               Database.LeadConvert lc = new database.LeadConvert();
               lc.setLeadId(l.Id);
               lc.convertedstatus='Closed - Converted';
               lc.ownerid='0055j000003je4GAAQ';
               Database.LeadConvertResult lcr = Database.convertLead(lc);  
             }         
        }
}