trigger SDap on EmployessDap__c (after insert)
{
    SecondDap.mymethod(trigger.new);
        
}