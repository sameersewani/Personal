public with sharing class AccountSearch 
{

    // @AuraEnabled(cacheable=true)
    // public static List<Account>  getAccounts(String actName)
    // {
    //     String keyString = '%'+actName+'%';
    //     return [select id,name from Account where name like:keyString];
    // }


    @AuraEnabled(cacheable=true)
    public static  List<Account> getRecords(String state, String city, String email)
    {
        String keyString = '%'+state+'%';
        String keyString1 = '%'+city+'%';
        String keyString2 = '%'+email+'%';
        List<Account> alist=[select id,name,state__c,City__c,AccountEmail__c from Account where state__c like:keyString and City__c like:keyString1 and AccountEmail__c like:keyString2];
        return alist;
    }

    @AuraEnabled(cacheable=true)
    public static  List<Contact> getContacts(String AId)
    {
        return[select LastName from Contact where AccountId=:AId];

    }

    


}