public without sharing class getData 
{
    @AuraEnabled
    public static Map<string,string> getBudget(String nameofuser,String useremail,String userFirstname,String userLastname)
    {
        Map<string,string> mmap= new Map<string,string>();
        system.debug('name'+nameofuser);
        List<user> headers =[select username from user where username=:nameofuser];
        system.debug('get data'+headers);
        if(headers.size()==0)
        {
            system.debug('no user');
            Account a = [SELECT Id FROM account WHERE name='Sameer sso'];
            system.debug('account'+a);
            Contact c = new Contact();
            c.accountId = a.Id;
            c.email = useremail;
            c.lastName =userLastname;
            insert c;
            system.debug('contact'+c);
            
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name='Customer Community Plus Login User'];
            u.username = nameofuser;
            u.email = useremail;
            u.lastName = userLastname;
            u.firstName = userFirstname;
            u.alias = 'Test';
            u.languagelocalekey = 'en_US';
            u.localesidkey = 'en_US';
            u.emailEncodingKey = 'ISO-8859-1';
            u.timeZoneSidKey = 'America/New_York';
            u.profileId = p.Id;
            u.contactId = c.Id;
            insert u;
            system.debug('user'+u);
            mmap.put('success','User Created');
        }
        else
        {
            system.debug('got the user');
            mmap.put('error','User Exist');
            
        }
        return mmap;
    }
}