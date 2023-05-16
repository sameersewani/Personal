public class StripeFlow 
{
    public class recordInput
    {       
        @InvocableVariable
        public String getName;        
    }
    @InvocableMethod(label = 'StripeCall' description = 'To Call The Api')
    public static void StripeCall(List <recordInput> Inputs)
    {
        String fieldname = Inputs.get(0).getName;
        customer(fieldname);
    }
    
    @future(callout=true) 
    public static void customer(String fieldname)
    {
        HTTP h = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.stripe.com/v1/customers');
        req.setMethod('POST');
        string token='sk_test_51L8IJTAgRJNLwrDT06ZO9xWB2CO7uEnQ6Vnjmb2BJA9pxGFIorbIm9PiqE7kQ4wTUqP2AhNqSz3ImlRShL67P8Lv00EO5OkBoX';
        req.setHeader('Authorization','Bearer '+token);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        string body='description='+fieldname;
        req.setBody(body);        
        HTTPResponse res =h.send(req);
        Map<string,Object> customer=(Map<string,object>)JSON.deserializeUntyped(res.getBody());
        system.debug(customer); 
        
        String customerId=(String)customer.get('id');
        system.debug(customerId);
    }
    
}