trigger mock on Account (before insert) 
{
    String u= UserInfo.getUserId();
    List<Account> alist=[select id from Account where Ownerid=:u];
    /*Account a= trigger.new[0];		
        if(!(alist.size()<200))
        {
            a.adderror('you cant insert the record as 200 limit has exceed');
        }*/
    
    
    for(Account a: trigger.new)
    {
        if(!(alist.size()<200))
        {
            a.adderror('you cant add more record');
        }
    }
   

}