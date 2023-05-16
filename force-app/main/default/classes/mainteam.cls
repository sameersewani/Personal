public class mainteam 
{
    
    public static void main()
    {
        
        User u = new user();
        u.LastName = 'Sehwani';
        u.Email = '	sameer09@cyntexa.com';
        u.Alias = 'Scode';
        u.Username = 'newsameer@salesforce122.com';
        u.CommunityNickname = 'test1212';
        u.LocaleSidKey = 'en_US';
        u.TimeZoneSidKey = 'GMT';
        u.ProfileID = '00e5j00000120P3AAI'; //deactivate the user of that particular id(cashier)
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.IsActive = false;
        insert u;
        
    }
    
}