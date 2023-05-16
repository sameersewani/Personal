public class HubspotController
{
    //public String urlRedirection{get;set;}
    
    public static PageReference mymeth()
    {
        
 		PageReference pref = new PageReference('https://app.hubspot.com/oauth/authorize?client_id=e6db55ac-a60c-420d-ab8e-d24854b343b6&redirect_uri=https://cyntexa-2c6-dev-ed--c.visualforce.com/apex/HubspotVF&scope=crm.objects.contacts.read%20crm.objects.contacts.write%20crm.objects.companies.write%20crm.objects.companies.read');
        pref.setRedirect(true);
        return pref;
    }
    
    
    public static void geturlRedirection()
    {
        //To genereate Refresh token with the help of Authorization Code.
        
        String code = ApexPages.currentPage().getparameters().get('code');
        System.debug('Authorization code : '+code);       
        String clientId = 'e6db55ac-a60c-420d-ab8e-d24854b343b6';
        String clientSecret = 'b232253d-ed4d-4f87-88f4-d671fbe0c15d';
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/oauth/v1/token');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setMethod('POST');
        String body =  'grant_type=authorization_code&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&code='+code+'&redirect_uri=https://cyntexa-2c6-dev-ed--c.visualforce.com/apex/HubspotVF';
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