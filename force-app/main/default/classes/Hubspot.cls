public class Hubspot 
{    
    public static void getAccessToken()
    {
         //To genereate new Access Token using Refresh token
         
         String clientId = 'e6db55ac-a60c-420d-ab8e-d24854b343b6';
        String clientSecret = 'b232253d-ed4d-4f87-88f4-d671fbe0c15d';
        REfres__c rtt=[select name from REfres__c order by CreatedDate  desc limit 1];
        String rtoken = (String)rtt.name;
        system.debug(rtoken);
        
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.hubapi.com/oauth/v1/token');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setMethod('POST');
        String body =  'grant_type=refresh_token&client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&client_secret='+EncodingUtil.urlEncode(clientSecret,'UTF-8')+'&refresh_token='+EncodingUtil.urlEncode(rtoken,'UTF-8');
        //System.debug('Body in getAccessToken: '+body);
        request.setBody(body);   
        
        
        HttpResponse response = h.send(request);
        //System.debug('Response in getRefreshToken:'+response);
        
         Map<string,Object> result=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug(result);
        
         String AccessToken=(String)result.get('access_token');
        system.debug(AccessToken);
        
        
        // --------------------to get Contacts---------------------------------------------------
        List<Contact> clist=[select LastName,EmailC__c from contact];
        List<Contact> UpdateList=new list<Contact>();
        List<Contact> addlist=new List<Contact>();
        
        List<String> Namelist=new List<String>();// stores last name
        List<String> EmailList=new List<String>();// stores Email
  
        HttpRequest request1 = new HttpRequest();
        request1.setEndpoint('https://api.hubapi.com/crm/v3/objects/contacts?limit=20&archived=false');
        request1.setHeader('authorization', 'Bearer '+AccessToken);
        request1.setHeader('content-type', 'application/json');
        request1.setMethod('GET');
        
        HTTPResponse res =h.send(request1); 
        system.debug(res);
        Map<String,Object> rawObj = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('rawObj'+rawObj);
        
        List<Object> resultget = (List<Object>)rawObj.get('results');
        System.debug(resultget);
        
        for(Contact c : clist)
        {
            Namelist.add(c.LastName);
            EmailList.add(c.EmailC__c);
        } 
        
        for(Object abc : resultget)
        {
            Map<String,Object> result1 = (Map<String,Object>)abc;
            //System.debug(result1);
            
            Map<String,Object> result2 = (Map<String,Object>)result1.get('properties');
            //System.debug(result2);
                    
            String resEmail=(String)result2.get('email');
           // system.debug(resEmail);
            
            String resName=(String)result2.get('firstname');
            system.debug(resName); 
            
            
            
            if(!Namelist.contains(resName) && (!EmailList.contains(resEmail)) )
            {
                Contact cr= new Contact();
                cr.LastName=resName;
                cr.EmailC__c=resEmail;
                addlist.add(cr); 
                
            }
            else if(EmailList.contains(resEmail))
            {
                system.debug('phle se hai');
                 for(Contact c : clist)
                 {
                     if(c.EmailC__c==resEmail)
                     {
                         c.LastName=resName;
                         UpdateList.add(c);
                     }
                 }                          
            }
            
        }
        system.debug(addlist);
        insert addlist;
        update UpdateList;
    }
	
}  
    
    
    
    
    // ------------------------------------------from Api key----------------------------------------------
    // 
    // 
    /*public static void getContacts()
    {
        List<Contact> clist=[select LastName from contact];
        List<Contact> addlist=new List<Contact>();
        List<String> Namelist=new List<String>();
        HTTP h = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.hubapi.com/crm/v3/objects/contacts/?archived=false&hapikey=840981fa-e5d7-4c6e-8e91-b28b71682ced');
        req.setHeader('content-type', 'application/json');
         req.setMethod('GET');
        
        HTTPResponse res =h.send(req); 
        Map<String,Object> rawObj = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        System.debug('rawObj'+rawObj);
        
        List<Object> result = (List<Object>)rawObj.get('results');
        System.debug(result);
        
        for(Contact c : clist)
        {
            Namelist.add(c.LastName);      
        } 
        
        for(Object abc : result)
        {
            Map<String,Object> result1 = (Map<String,Object>)abc;
            //System.debug(result1);
            
            Map<String,Object> result2 = (Map<String,Object>)result1.get('properties');
            //System.debug(result2);
            
            String resName=(String)result2.get('firstname');
            system.debug(resName); 
            
            if(!Namelist.contains(resName))
            {
                Contact cr= new Contact();
                cr.LastName=resName;
                addlist.add(cr);
                
            }
        }
        system.debug(addlist);
        insert addlist;
   
    }*/