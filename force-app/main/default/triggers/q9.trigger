trigger q9 on Opportunity (before insert) 
{
     ID user = UserInfo.getUserId();
    
     List<Opportunity> olist= [Select Id, StageName From Opportunity Where CreatedById =:user];
    for(Opportunity o : trigger.new)
    {
        if(olist.size() > 2 ) 
       {
         o.adderror('you cant make any new Opportunity');
        }   
        
    }
    

}