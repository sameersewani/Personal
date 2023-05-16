public without sharing class CheckValues 
{
    @AuraEnabled
    public static List<sobject> getdata(String clientid,String getemail,String pnum)
    {
        List <sobject> ss= new List<Sobject>();
        Account acc=[select id,Client_Id__c from account where Client_Id__c=:clientid];
        Contact con=[select id, Phone, Email from contact where Phone=:pnum and Email=:getemail];
        ss.add(acc);
        ss.add(con);
        system.debug('re'+ss);
        return ss;
    }
    
    @AuraEnabled
    public static Map<String,String> checkdata(String useremail)
    {
        Map<string,string> mmap= new Map<string,string>();
        system.debug('email '+useremail);
        
        List<Contact> con =[select id,email from Contact where email=:useremail];
        system.debug('get data'+con);
        
        if(con.size()==0)
        {
            system.debug('no user');
            Account a = [SELECT Id FROM account WHERE id='0015j00000x0AflAAE'];
            system.debug('account'+a);
            Contact c = new Contact();
            c.accountId = a.Id;
            c.email = useremail;
            c.lastName =useremail+'LastName';
            insert c;
            system.debug('contact'+c);
            
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name='Customer Community Plus Login User'];
            u.username = useremail;
            u.email = useremail;
            u.lastName = useremail+'LastName';
            u.firstName = useremail+'FirstName';
            u.alias = 'Test';
            u.languagelocalekey = 'en_US';
            u.localesidkey = 'en_US';
            u.emailEncodingKey = 'ISO-8859-1';
            u.timeZoneSidKey = 'America/New_York';
            u.profileId = p.Id;
            u.contactId = c.Id;
            insert u;
            system.debug('user'+u);
            mmap.put('success',useremail);
        }
        else
        {
            system.debug('got the user');
            mmap.put('error','User Exist');
            
        }
        return mmap;
    }
    
    
}