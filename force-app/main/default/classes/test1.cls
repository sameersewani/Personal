public class test1 
{
    	
    public static void sendMailOnUpdate(Id accId, Id oldOwnerId, Id newOwnerId)
    {
        Account accountDetails = [SELECT Id, Name, Phone, OwnerId, email__c, Type, Rating FROM Account where Id = :accId];
        system.debug(accountDetails);
    
        List<Contact> contactDetails = [SELECT Id, LastName, FirstName, AccountId, Phone FROM Contact where AccountId = :accId ];
		system.debug(contactDetails);
        
        User oldOwner = [SELECT Id, Username, Name, Email, ManagerId FROM User where Id = :oldOwnerId];
		system.debug(oldOwner);
        
        User newOwner = [SELECT Id, Username, Name, Email, ManagerId FROM User where Id = :newOwnerId];
		system.debug(newOwner);
        
        User oldManager = [SELECT Id, Username, Name, Email FROM User where Id = :oldOwner.ManagerId];
		system.debug(oldManager);
        
        User newManager = [SELECT Id, Username, Name, Email FROM User where Id = :newOwner.ManagerId];
		system.debug(newManager);
        
        // mail to new user
                List<Messaging.SingleEmailMessage> mails1 = new List<Messaging.SingleEmailMessage>();      
                Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(newManager.Email);
                mail1.setToAddresses(sendTo);
                mail1.setSubject('Account Deatils'); 
                String body1 = ' Account and related contact deatils '+accountDetails.name + ' '+accountDetails.Phone+' '+contactDetails.size();  
                mail1.setHtmlBody(body1);
                mails1.add(mail1);      
                Messaging.sendEmail(mails1);
        
        // mail to old user
			 List<Messaging.SingleEmailMessage> mails12 = new List<Messaging.SingleEmailMessage>();      
                Messaging.SingleEmailMessage mail12 = new Messaging.SingleEmailMessage();
                List<String> sendTo12 = new List<String>();
                sendTo12.add(oldManager.Email);
                mail12.setToAddresses(sendTo12);
                mail12.setSubject('Account Deatils'); 
                String body12 = ' Account has been transferred to another user';  
                mail12.setHtmlBody(body12);
                mails12.add(mail12);      
                Messaging.sendEmail(mails12);
                
  
    }


}