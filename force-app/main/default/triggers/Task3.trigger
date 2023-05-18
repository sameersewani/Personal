trigger Task3 on Loan_Entity__c (before insert) 
{
   ApexTask3.mymethod(trigger.new);
    

}