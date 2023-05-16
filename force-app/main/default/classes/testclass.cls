public with sharing class testclass
 {
      @AuraEnabled(cacheable=true)
          public static List<Account> getaccounts()
          {
              return[select name,(select name from contacts),(select name from opportunities)from account limit 8];
          }


      
}