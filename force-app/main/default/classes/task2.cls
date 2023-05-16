public with sharing class task2 
{
    @AuraEnabled
    public static List<Class__c> ClassName()
    {
        List<Class__c> cList=[select name from Class__c]; 
        return cList;   
    }

    @AuraEnabled
    public static List<ClassStudent__c> StudentName(Id cID)
    {
        List<ClassStudent__c> sList=[select name,RollNo__c,SrNO__c,Marks__c from ClassStudent__c where Class__c=:cID]; 
        return sList;
    }


    
}