public class a3q2 
{
    public static void main()
    {
       List<Account> accList = [Select name ,(select name from opportunities) from Account];
       List<Opportunity> oppList = new List<Opportunity>();
        Date d = Date.today() + 30;
        For(Account a:accList)
        {
            Opportunity o = new Opportunity(name = a.name + ' First Opportunity', AccountId = a.Id ,
                             StageName = 'Qualification', CloseDate = d);
            oppList.add(o);
        }
        insert oppList;
    }  
}