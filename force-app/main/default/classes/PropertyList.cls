public with sharing class PropertyList 
{
    @AuraEnabled(cacheable=true)    
    public static List<Property__c> getproperties()
    {
        return [select name,Photo__c from Property__c];
    }
}