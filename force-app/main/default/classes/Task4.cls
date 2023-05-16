public with sharing class Task4 
{
    @AuraEnabled
    public static List<Mail_Header__c> getMailheader()
    {
        List<Mail_Header__c> headers =[select Name,Assigned_To__c, Date_Received__c,Email_Category__c,Email_Subject__c,Priority__c,Tentative_Completion_Date__c from Mail_Header__c];
        
        return headers;
    }

    @AuraEnabled
    public static List<Mail_Chain__c> getMailchain(Id i)
    {
        System.debug(i);
        List<Mail_Chain__c> mc =[select Name,Subject__c,To__c,From__c,Email_Body__c,Date_and_Time_of_Email__c,CC__c,BCC__c from Mail_Chain__c where Mail_Header__c =:i];
        system.debug(mc);
        
        return mc;
    }

    @AuraEnabled
    public static List<Mail_Chain__c> getChain(Id Did)
    {
        List<Mail_Chain__c> mcc =[select Name,Subject__c,To__c,From__c,Email_Body__c,Date_and_Time_of_Email__c,CC__c,BCC__c from Mail_Chain__c where Mail_Header__c =:Did];
        Delete mcc;
        
        return mcc;
    }

    @AuraEnabled
    public static  List<Mail_Chain__c> getRecords(String email)
    {
        system.debug(email);
        String keyString = '%'+email+'%';
        List<Mail_Chain__c> llist =[select Name from Mail_Chain__c where To__c like:keyString or From__c like:keyString or CC__c like:keyString or BCC__c like:keyString];

        return llist;


    }


}