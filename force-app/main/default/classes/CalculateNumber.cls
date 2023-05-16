public with sharing class CalculateNumber {
    public CalculateNumber() 
    {

    }
    @AuraEnabled(cacheable=true)
    public static integer getSumResult(integer firstnumber,integer secondnumber)
    {
        return(firstnumber + secondnumber);
    }

}