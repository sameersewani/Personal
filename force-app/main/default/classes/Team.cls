public class Team 
{
    //onteamtrigger
    public static void main(List<Team__c> newteam)
    {
        
        string ids;
        for(team__c t:newteam)
        {
            
            ids= t.Main_Team__c;
        }
        system.debug('ids'+ids);
        List<team__c> oldteam=[Select name from team__c where Main_Team__c=:ids];// old teams relaed to main team
        System.debug('size='+oldteam.size());
        
        if(oldteam.size()>=1)
        {
             
            /*for(team__c a:newteam)
            {
                a.addError('Each team has only one main account');
            }*/
        }
    }
}