public class checkopportunity 
{
    // to check number of opportunities
    public static void main(List<opportunity> newopportunity)
    {
        
        
        Set<String>ids=new Set<String>();
        
        for(opportunity t:newopportunity)
        {
            
            ids.add(t.Team__c);
        }
        system.debug('ids'+ids);
        List<opportunity> oldopportunity=[Select name from opportunity where Team__c IN :ids];
        System.debug('size='+oldopportunity.size());
        System.debug(oldopportunity);
        
        if(oldopportunity.size()>=5)
        {
            for(opportunity a:newopportunity)
            {
                a.addError('Each team can only have five related opportunities');
            }
        }
        
    }
    
    //--------------------------------------------------------
    
    public static void upd(List<opportunity> oldvalue,List<opportunity> newvalue)
    {
        System.debug(oldvalue);
        for(Opportunity x: newvalue)
        {
            
            List<OpportunityLineItem> oldproduct=[select name, quantity,opportunityId from OpportunityLineItem where opportunityId = : x.Id];
            List<Opportunity> emailopp=[Select opportunity.owner.email from Opportunity where id=:x.id];// email of opportunity owner
            List<opportunity> emailmainteam=[select opportunity.team__r.main_team__r.email__c from opportunity where id=:x.id];// email of main team
            System.debug('Date ====> ' + x.CloseDate + ', Size=====> ' + oldproduct.size() + ', Today ==> ' + Date.today());
            System.debug(x.CloseDate == Date.today());
            
            if(x.CloseDate == Date.today() && oldproduct.size() > 0)
            {
                if(x.StageName == 'Closed Won')
                {
                          System.debug('Stage Cheking...');
                    
                         //For owner template
                        for(Opportunity a:emailopp)
                        {
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                 EmailTemplate emailTemplate =[Select Id from EmailTemplate where name ='GreetingMessage'];
                                    mail.setTemplateID(emailTemplate.Id);
                            
                            String[] toAddresses = new String[] {a.owner.email};
                                // List<String> toAddresses=new  
                                mail.setToAddresses(toAddresses);
                            
                            mail.setSubject('hello Email owner');
                            
                            mail.setPlainTextBody('good');
                            
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        }
                             //For main team template
                          for(opportunity b:emailmainteam)
                          {
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                EmailTemplate emailTemplate =[Select Id from EmailTemplate where name ='WelcomeCustomer'];
                                mail.setTemplateID(emailTemplate.Id);
                        
                                String[] toAddresses = new String[] {b.team__r.main_team__r.email__c};
                                    // List<String> toAddresses=new  
                                    mail.setToAddresses(toAddresses);
                                
                                mail.setSubject('hello main team owner');
                                
                                mail.setPlainTextBody('good');
                                
                                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                         }
                    
                   }
                else if(x.StageName == 'Closed Lost')
                {
                        System.debug('true');
                        //For owner template
                        for(Opportunity a:emailopp)
                        {
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                 EmailTemplate emailTemplate =[Select Id from EmailTemplate where name ='GreetingMessage'];
                                    mail.setTemplateID(emailTemplate.Id);
                            
                            String[] toAddresses = new String[] {a.owner.email};
                                // List<String> toAddresses=new  
                                mail.setToAddresses(toAddresses);
                            
                            mail.setSubject('hello');
                            
                            mail.setPlainTextBody('good');
                            
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        }
                        //For main team template
                              for(opportunity b:emailmainteam)
                              {
                                  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                  EmailTemplate emailTemplate =[Select Id from EmailTemplate where name ='WelcomeCustomer'];
                                    mail.setTemplateID(emailTemplate.Id);
                            
                                    String[] toAddresses = new String[] {b.team__r.main_team__r.email__c};
                                        // List<String> toAddresses=new  
                                        mail.setToAddresses(toAddresses);
                                    
                                    mail.setSubject('hello');
                                    
                                    mail.setPlainTextBody('good');
                                    
                                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                               }

                  }
                    else
                    {
                            x.addError('Cannot Update');
                    }
                    
                }
                else if(x.CloseDate != Date.today() && x.StageName.contains('Closed'))
                {
                    system.debug('error aa gya');
                    x.addError('you cant change the stage name beacuse of close date');
                }
               else
                {
                    System.debug('Kuch na Hoga');
                }
            }
        }
    }