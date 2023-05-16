public class a3q4 
{
    public static void main()
    {
        List<Opportunity> opplist =[select name from Opportunity where StageName='qualification'];  
        for(Opportunity o: opplist)
        {
        o.StageName='sameer sons u';
        o.Type='new Account';
        }
		upsert opplist;            
        
    }

}