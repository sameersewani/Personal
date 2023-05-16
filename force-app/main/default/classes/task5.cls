public with sharing class task5
 {
    @AuraEnabled
    public static List<Opportunity> getopportunity()
    {
        List<Opportunity> headers =[select Name,Account.name,Amount,StageName,CloseDate,DueAmount__c,
        (select name from Payments__r) from Opportunity  ORDER BY Name DESC LIMIT 20];
        
        return headers;
    }
    @AuraEnabled
    public static List<Payment__c> getlinks(Id i)
    {
        List<Payment__c> headerss =[select Name from Payment__c where  Opportunity__c=:i];
        
        return headerss;
    }


}