public with sharing class Quiz
 {
    @AuraEnabled
          public static List<Question__c> getnames()
          {
            List<Question__c> names = [select Name,OptionA__c,OptionB__c,OptionC__c,Answer__c,SelectedValue__c,Correct__c from Question__c];
            
            for(Question__c a: names)
            {
                a.SelectedValue__c='a';
            }
            update names;
            return names;

          }
}