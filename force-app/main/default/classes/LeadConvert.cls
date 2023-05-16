global class LeadConvert implements Database.Batchable<sObject> 
{
     public static Integer vowel(String name)
    {
        String vowel='aeiou';
        Integer count=0;
        for(String v:name.split(''))
        {
            if(vowel.contains(v))
            {
                count++;
            }
        }
        system.debug(count);
        return count;
        
    }
    
    public static Boolean checkUser(ID userid)
    {
        try
        {
             User u=[select LastLoginDate from user Where id=:userid And LastLoginDate >= :(Date.today()-25) ];
             return true;
            
        }
        catch(Exception e)
        {
            return false;
        }
       
    }
    List <lead> l2= new List <lead>();
    public LeadConvert(List<lead> l1)   // constructor 
    {
        l2=l1;
        
    }
    global List<Lead> start(Database.BatchableContext BC)
    {    
        system.debug('start');
        return l2;
    }
    global void execute(Database.BatchableContext bc, List <Lead> llist)
    {
        system.debug('execute');
        List<Id> idList = new List<id>();
        for(Lead l : lList)
        {
            idList.add(l.id);
        }
         list<Lead> l5 =new list<Lead>();
        List<Lead> Leads = [Select Name, Id,Company_Size__c,City__c,Special_Lead__c,Company,OwnerId,LastModifiedDate  from Lead where Id IN :idList];
        Integer count=0;
        
        for(Lead x:Leads)
        {
            if(x.Company_Size__c>500)
            {
                count++;
            }
            if(x.City__c =='Tier-1')
            {
                count++;
            }
            if(vowel(x.Company)>=2)
            {
                count++;
            }
            if(checkUser(x.OwnerId))
            {
                count++;
            }
            if(count==4)
            {
               x.Special_Lead__c=true;
                l5.add(x);
            }  
           
            update x;
            
        }          
    }  
    
    
    global void finish(Database.BatchableContext bc)
    {
            System.debug('Finished!');
       
            User u=[SELECT name, Email,profile.name,userrole.name FROM User];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {u.Email};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Total number of leads ');
            mail.setPlainTextBody('records processed ');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        
            Lead l=[SELECT Referral_Person_Name__c,Referral_Person_Email__c,Referral_Person_Organization__c,Referral_Type__c from Lead];
            Messaging.SingleEmailMessage mail1 = new Messaging.SingleEmailMessage();
            String[] toAddresses1 = new String[] {l.Referral_Person_Email__c};
            mail1.setToAddresses(toAddresses1);
            mail1.setSubject('Total number of leads ');
            mail1.setPlainTextBody('Referal ');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail1 });     
    }    
}