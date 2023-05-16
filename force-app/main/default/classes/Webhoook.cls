@RestResource(urlMapping='/Webhooks/*')
global class Webhoook 
{
    @HttpPost
    global static String handleNotifications()
    {

            RestRequest req=RestContext.request;
            RestResponse res=RestContext.response;
            String str=req.requestBody.toString();
            system.debug('str -->'+str);
            Account acc=[select Description from Account where id='0015j00000i0uiDAAQ'];
            acc.Description=str;
        
            QuickbookWrapper wrap=(QuickbookWrapper)JSON.deserialize(str, QuickbookWrapper.class);
            String AccId=wrap.eventNotifications[0].dataChangeEvent.entities[0].id;
        	acc.external_id__c=AccId;
            system.debug('AccId -->'+AccId);
        	
        
        String clientId = 'ABjNgWBmGjU6yptw5eVbhd41Xuy2sGhHSIx9wMm1D3jFGNICYw';
        String clientSecret = 'K1yQOVSL7xRJnsyKWkWdjJbuALKGTKHCEHECNJCE';
        REfres__c rtt=[select name from REfres__c order by CreatedDate  desc limit 1];
        String rtoken = (String)rtt.name;
        system.debug('rtoken------'+rtoken);
        
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setMethod('POST');
        String body =  'grant_type=refresh_token&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&refresh_token='+EncodingUtil.urlEncode(rtoken,'UTF-8');
        System.debug('Body in getAccessToken: '+body);
        request.setBody(body);   
               
        HttpResponse response = h.send(request);
        System.debug('Response in getRefreshToken:'+response);
        
        Map<string,Object> result=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug('result----'+result);
        
        String AccessToken=(String)result.get('access_token');
            system.debug('AccessToken------'+AccessToken);
     
      
        
        HTTPRequest req1 = new HTTPRequest();
        req1.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365220401130/customer/'+AccId+'?minorversion=65');
        req1.setHeader('Accept', 'application/json');
        req1.setHeader('Authorization', 'Bearer '+AccessToken);
        req1.setMethod('GET');   
        
        HTTPResponse res1 =h.send(req1); 
        system.debug(res1);
        Map<String,Object> rawObj = (Map<String,Object>) JSON.deserializeUntyped(res1.getBody());
        System.debug('rawObj'+rawObj);
        
        Map<String,Object> rawObj2 = (Map<String,Object>)rawObj.get('Customer');
        System.debug('rawObj2'+rawObj2);
        
        String strObj = string.valueOf(rawObj2.get('DisplayName'));
        System.debug('strObj-----'+strObj);
        
        Account a= new Account();
        a.Name=strObj;
        insert a;
        
        update acc;
        
          return 'sameer';
    }

    
}