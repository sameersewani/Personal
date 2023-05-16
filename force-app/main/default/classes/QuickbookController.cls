public class QuickbookController 
{
 
    //public String urlRedirection1{get;set;}
    
    public static PageReference mymeth1()
    {
        
 		PageReference pref = new PageReference('https://appcenter.intuit.com/connect/oauth2?client_id=ABjNgWBmGjU6yptw5eVbhd41Xuy2sGhHSIx9wMm1D3jFGNICYw&redirect_uri=https://cyntexa-2c6-dev-ed--c.visualforce.com/apex/Quickbook&scope=com.intuit.quickbooks.accounting&response_type=code&state=SAMEER');
        pref.setRedirect(true);
        return pref;
    }
    
    
    public static void geturlRedirection1()
    {
        //To genereate Refresh token with the help of Authorization Code after successfull authentication of user
        
        String code = ApexPages.currentPage().getparameters().get('code');
        System.debug('Authorization code : '+code);       
        String clientId = 'ABjNgWBmGjU6yptw5eVbhd41Xuy2sGhHSIx9wMm1D3jFGNICYw';
        String clientSecret = 'K1yQOVSL7xRJnsyKWkWdjJbuALKGTKHCEHECNJCE';
        
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setMethod('POST');
        String body =  'grant_type=authorization_code&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&code='+code+'&redirect_uri=https://cyntexa-2c6-dev-ed--c.visualforce.com/apex/Quickbook';
        request.setBody(body);   
        
        HttpResponse response = h.send(request);
        System.debug('Response in getRefreshToken:'+response);
        
        Map<string,Object> pro=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug(pro);
        String refreshToken=(String)pro.get('refresh_token');
        system.debug(refreshToken);
        
        if(refreshToken!=null)
        {
            REfres__c rt=new REfres__c(Name=refreshToken);
            insert rt;
        }
    }
    

}