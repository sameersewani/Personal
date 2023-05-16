public class twillio 
{
    @future(callout=true)
    public static void callout(String num)
    {
        long tonum=long.valueOf(num);
        HTTP h = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/AC75cb80be356e6c0cc0c7fbcebc37c041/Calls.json');
        
        String username = 'AC75cb80be356e6c0cc0c7fbcebc37c041';
        String password = '21a0fb6dc87f02f9ae059fb2a6a46ac2';
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'BASIC ' +EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setMethod('POST');
        
        String body =  'Twiml=<Response><Say>Ahoy there$EXCLAMATION_MARK</Say></Response>&To=+91 '+tonum+'&From=+1 424 785 2082';
        System.debug('Body in getAccessToken: '+body);
        req.setBody(body);  
        
        HTTPResponse res =h.send(req);
        System.debug(res.getBody());
    }
    
    
}