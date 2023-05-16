public class LeadConvert1
{
    public static void main()
    {
        Lead l =[Select name From lead];
        Database.LeadConvert lc = new Database.LeadConvert();
        
        lc.setLeadId(l.id);
        lc.convertedstatus ='Closed - Converted';
        lc.ownerID='0055j000003je4GAAQ';
        Database.LeadConvertResult lcr =Database.convertlead(lc);
        
    }
    
}