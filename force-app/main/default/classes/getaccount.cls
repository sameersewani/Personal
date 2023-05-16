public with sharing class getaccount 
{
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts ()
    {
        List<Account> accList=[Select Id, Name From Account];    
        return acclist;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts( String selectedAccountId)
    {
    List <Contact> contactList=[Select Id, Name, Email,AccountId From Contact Where AccountId=: selectedAccountId];
    return contactList;
    }  
}