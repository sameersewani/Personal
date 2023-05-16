public class a5q1controller 
{

    public List<Account> AccList{get;set;}
    public a5q1controller(ApexPages.StandardController s)
    {
        AccList = [Select Name, NumberOfEmployees, Type, AnnualRevenue, Industry from Account order by Name];
     }
    
    

}