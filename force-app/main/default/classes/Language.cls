public class Language 
{
     @future(callout=true)
    public static void getAccountLanguage(String i)
    {
         Account acc = [SELECT Id, Name,Phone,LocalLanguage__c,AccountEmail__c FROM Account where id = :i];
        
	            HTTP h = new HTTP(); 
            HTTPRequest req = new HTTPRequest();
            req.setEndpoint('https://deep-translate1.p.rapidapi.com/language/translate/v2');
            req.setHeader('content-type', 'application/json');
            req.setHeader('X-RapidAPI-Host', 'deep-translate1.p.rapidapi.com');
            req.setHeader('X-RapidAPI-Key', '9b4002c4e2mshd7aa7a31f0a08d9p1e2148jsnc050cf6811ba');
            req.setMethod('POST');
        
          
         
            string target;
            string source= acc.LocalLanguage__c;
            system.debug(source);
           if(source=='hindi')
            {        
                target='hi';
            }
            if(source=='arabic')
            {
                target='ar';
            }
            if(source=='bengali') 
            {
                target='bn';
            }
            if(source=='french')
            {
                target='fr';
            }
            if(source=='danish') 
            {
                target='da';
            }
            if(source=='tamil')
            {
                target='ta'; 
            }
        
            string body='{"q": "'+acc.Name+'" , "source": "en", "target":"'+target+'"}';
            req.setBody(body);
                
             HTTPResponse res =h.send(req);
            Map<String,Object> jsonBody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            system.debug(jsonBody);
        
            Map<String,Object> trans = (Map<String,Object>)jsonBody.get('data');
            system.debug(trans);
        
            Map<String,Object> tran = (Map<String,Object>)trans.get('translations');
            system.debug(tran); 
                
            string s=(string)tran.get('translatedText');
        
           acc.Name=s;
          system.debug(s);
          update acc;
        
        // to send email
       
             List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();      
             if (acc.AccountEmail__c != null )
             {
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             List<String> sendTo = new List<String>();
             sendTo.add(acc.AccountEmail__c);
             mail.setToAddresses(sendTo);
                    
             mail.setSubject('Your contact detail are added'); //Subject of the mail and the body of the mail
             String body1 = 'You created a new account =' + acc.Name + ' ,you have choosed this language= '+acc.LocalLanguage__c + '  ,your Phone number =' + acc.Phone;    
             mail.setHtmlBody(body1);
             mails.add(mail);        
             Messaging.sendEmail(mails);
         }

    }
}