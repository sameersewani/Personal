public class a3q8 
{
    public static void main()
    {
          List<Account> accList = [SELECT id , (select name from opportunities)from Account Where Opportunity_Count__c > 2 ];
        delete accList;
    }

}