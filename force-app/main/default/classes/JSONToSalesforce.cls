public with sharing class JSONToSalesforce 
{
    @AuraEnabled
    public static void mymethod(String getdata)
    {
        List<Account>acc=(List<Account>)JSON.deserializeStrict(getdata,List<Account>.class);
        system.debug(getdata);
        system.debug(acc);
        insert acc;
        
    }
}