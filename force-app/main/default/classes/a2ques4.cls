public class a2ques4 {
    public static void main()
    {
        String user1=UserInfo.getUserId();
        List<Opportunity>l1=[select name from opportunity where name like '%Test%' And CloseDate=THIS_FISCAL_YEAR And OwnerID=:user1 ];
        System.debug(l1);
        
    }


}