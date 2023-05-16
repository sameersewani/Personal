public with sharing class AccountCreationList {
    public AccountCreationList() 
    {
        
    }
      @AuraEnabled
      public static Account createAccount(Account accountRecObj)
      { 
          try 
          {
            insert accountRecObj;
            return accountRecObj;

          } 
          catch (Exception ex)
           {
            throw new  AuraHandledException(ex.getMessage());
              
          }
          
      }
    
}