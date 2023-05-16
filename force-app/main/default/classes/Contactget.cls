public with sharing class Contactget
 {
     @AuraEnabled(cacheable = true)
     public static List<Contact> getContact()
     {
        List<Contact> contactList =[Select id,name,phone,AccountID from contact];
        return contactList;
     }
   
}