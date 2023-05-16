public with sharing class Practice 
{
          @AuraEnabled
          public static List<CourseTest__c> getcourse()
          {
              return[select name,id,(select name,Overall_Marks__c from trainees__r) from CourseTest__c];
          }

}