public class ToolingApi 
{
    //Retrieve custom objects of Org
    public static void getCustomObjectFields()
    {
        string toolingSOQL = '/services/data/v57.0/tooling/sobjects/Account/';
        String baseURL = URL.getsalesforceBaseUrl().toExternalForm();
        string endpoint = baseURL+toolingSOQL;
        
        Http NewReq = new Http();
        HttpRequest hreq = new HttpRequest();
        hreq.setHeader('Authorization', 'Bearer '+UserInfo.getSessionId());
        hreq.setTimeout(60000);
        hreq.setEndpoint (endpoint);
        hreq.setMethod('GET');
        HttpResponse hresp = NewReq.send(hreq);
        
        string body = hresp.getBody();
        system.debug('ResponseBody: ' + body );
        List<Object> customObjMap = (List<Object>)Json.deserializeUntyped(body);
        //Map<String,Object> customObjMap = (Map<String,Object>)Json.deserializeUntyped(body);
        system.debug('Custom object = '+customObjMap);
    }
    
}