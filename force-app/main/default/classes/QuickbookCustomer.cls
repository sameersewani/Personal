public class QuickbookCustomer 
{
     @future(callout=true)       
    public static void setCustomer(String i)
    {
        
        String clientId = 'ABjNgWBmGjU6yptw5eVbhd41Xuy2sGhHSIx9wMm1D3jFGNICYw';
        String clientSecret = 'K1yQOVSL7xRJnsyKWkWdjJbuALKGTKHCEHECNJCE';
        REfres__c rtt=[select name from REfres__c order by CreatedDate  desc limit 1];
        String rtoken = (String)rtt.name;
        system.debug(rtoken);
        
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
        system.debug(result);
        
         String AccessToken=(String)result.get('access_token');
        system.debug(AccessToken);
     
        //---------------------------------------Vendor-----------------------------------------------------
        
        
            Account acc = [SELECT Name,Phone,BillingAddress,AccountEmail__c,Line1__c,City__c, Country__c,CountrySubDivisionCode__c,PostalCode__c from Account where Id = :i limit 1];
            HTTPRequest req1 = new HTTPRequest();
            req1.setEndpoint('https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365220401130/vendor?minorversion=65');
            req1.setHeader('Accept', 'application/json');
	        req1.setHeader('Content-Type', 'application/json');	
            req1.setHeader('Authorization', 'Bearer '+AccessToken);
           req1.setMethod('POST');   
           req1.setBody('{\"BillAddr\":{\"Line1\":\"DiannesAuto\",\"Line2\":\"Dianne\",\"Line3\":\"29834M.\",\"City\":\"Millbr\",\"Country\":\"U.S.\",\"CountrySubDivisionCode\":\"CA\",\"PostalCode\":\"94030\"},\"TaxIdentifier\":\"99-5688293\",\"AcctNum\":\"35372649\",\"Title\":\"Mr.\",\"GivenName\":\"raviiii\",\"FamilyName\":\"Bradey\",\"Suffix\":\"Sr.\",\"CompanyName\":\"DiannesAutoSp\",\"DisplayName\":\"'+acc.Name+'\",\"PrintOnCheckName\":\"DiannesAutoShop\",\"PrimaryPhone\":{\"FreeFormNumber\":\"(650)555-2342\"},\"Mobile\":{\"FreeFormNumber\":\"(650)555-2000\"},\"PrimaryEmailAddr\":{\"Address\":\"dbradley@myemail.com\"},\"WebAddr\":{\"URI\":\"http://DiannesAutoShop.com\"}}');
            HTTPResponse res1 =h.send(req1); 
             system.debug(res1);
            Map<String,Object> rawObj = (Map<String,Object>) JSON.deserializeUntyped(res1.getBody());
            System.debug('rawObj'+rawObj);
            
            Map<String,Object> rawObj2 = (Map<String,Object>)rawObj.get('Vendor');
            System.debug('rawObj2'+rawObj2);
            
            String strObj = string.valueOf(rawObj2.get('Id'));
            System.debug(strObj);
          }
}