public with sharing class Exam 
{
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getopportunity(String oppname)
    {
        String keyString = '%'+oppname+'%';
        List<Opportunity> headers =[select Name,Account.name,Amount from Opportunity
        where Name like:keyString LIMIT 5];
        
        return headers;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getaccount(String Accname)
    {
        String keyString1 = '%'+Accname+'%';
        List<Account> headd =[select Name,Opportunity_count__c from Account where Name like:keyString1  LIMIT 5];
        return headd;    
    }

    @AuraEnabled
    public static List<Opportunity> getnames(String AId,String OId)
    {
      List<Opportunity> names = [select id,Name,AccountId from Opportunity where id=:OId];
        system.debug(names);
      
      for(Opportunity o: names)
      {
        if(o.AccountId==null)
        {
            system.debug('if');
            o.AccountId=Aid;
        }
        else
        {
            o.AccountId=Aid;
        }
        
      }
      update names;
       system.debug(names);
      return names;
    }

    @AuraEnabled
    public static List<Account> getacc(String Acid)
    {
        List<Account> headd =[select Name,Opportunity_count__c from Account where id=:Acid ];
        return headd;    
    }

}