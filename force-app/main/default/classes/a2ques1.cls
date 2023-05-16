public class a2ques1 
{
    public static void main()
    {
        String user1=UserInfo.getUserId();
        AggregateResult ar1=[select sum(amount) from opportunity 
                             where stagename='closed won'and OwnerID=:user1 And CloseDate=THIS_FISCAL_YEAR];
        
          System.debug(ar1);
        
        
    }
    
    

}