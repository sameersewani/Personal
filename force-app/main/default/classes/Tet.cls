public with sharing class Tet
 {
    @AuraEnabled
    public static List<AggregateResult> myMethod()
    {
       return [select StageName from opportunity group by StageName];
    }
    @AuraEnabled
    public static List<Opportunity> myMethod2(String stageName)
    {
      return [select id, AccountId, Amount, StageName from Opportunity where StageName = :stageName];
    }
   
}