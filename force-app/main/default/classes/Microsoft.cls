//TODO:This autogenerated class includes the basics for a Registration
//Handler class. You will need to customize it to ensure it meets your needs and
//the data provided by the third party.

global class Microsoft implements Auth.RegistrationHandler{
    global boolean canCreateUser(Auth.UserData data) 
    {
        return null;
    }
    
    global User createUser(Id portalId, Auth.UserData data)
    {
        system.debug('data'+data);
        /*if(!canCreateUser(data)) 
{
//Returning null or throwing an exception fails the SSO flow
return null;
}*/
        if(data.attributeMap.containsKey('sfdc_networkid')) 
        {
            
            //We have a community id, so create a user with community access
            //TODO: Get an actual account
            Account a = [SELECT Id FROM account WHERE name='Sameer sso'];
            system.debug('a'+a);
            Contact c = new Contact();
            c.accountId = a.Id;
            c.email = data.email;
            c.lastName = data.username+'@cyntexa.com';
            insert c;
            system.debug('c'+c);
            
            //TODO: Customize the username and profile. Also check that the username doesn't already exist and
            //possibly ensure there are enough org licenses to create a user. Must be 80 characters or less.
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name='Customer Community Plus Login User'];
            u.username = data.username+'my@org.com';
            u.email = data.username+'@cyntxa.com';
            system.debug('ee'+data.email);
            u.lastName = data.username+'lastname';
            u.firstName = data.username+'firstname';
            String alias = 'Test';
            system.debug('u'+u);
            system.debug('username'+data.username);
            system.debug('username'+alias.length());
            //Alias must be 8 characters or less
            if(alias.length() > 8) 
            {
                alias = alias.substring(0, 8);
            }
            u.alias = alias;
            u.languagelocalekey = 'en_US';
            u.localesidkey = 'en_US';
            u.emailEncodingKey = 'ISO-8859-1';
            u.timeZoneSidKey = 'America/New_York';
            u.profileId = p.Id;
            u.contactId = c.Id;
            insert u;
            system.debug('u'+u);
            return u;
        } 
        else 
        {
            //This is not a community, so create a regular standard user
            User u = new User();
            Profile p = [SELECT Id FROM profile WHERE name='Chatter Free User'];
            //TODO: Customize the username. Also check that the username doesn't already exist and
            //possibly ensure there are enough org licenses to create a user. Must be 80 characters
            //or less.
            u.username = 'username@myorg.com';
            u.email = 'email@cyntexa.com';
            u.lastName = 'lastname';
            u.firstName = 'firstname';
            String alias = 'username@myorg.com';
            //Alias must be 8 characters or less
            if(alias.length() > 8) 
            {
                alias = alias.substring(0, 8);
            }	
            u.alias = alias;
            u.languagelocalekey = 'en_US';
            u.localesidkey = 'en_US';
            u.emailEncodingKey = 'ISO-8859-1';
            u.timeZoneSidKey = 'America/New_York';
            u.profileId = p.Id;
            insert u;
            return u;
        }
    }
    
    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        User u = new User(id=userId);
        //TODO: Customize the username. Must be 80 characters or less.
        //u.username = data.username + '@myorg.com';
        u.username = 'username@myorg.com';
        u.email = 'email@cyntexa.com';
        u.lastName = 'lastname';
        u.firstName = 'firstname';
        String alias = 'username@myorg.com';
        //Alias must be 8 characters or less
        //if(alias.length() > 8) {
        //alias = alias.substring(0, 8);
        //}
        //u.alias = alias;
        update u;
    }
}