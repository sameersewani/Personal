public class testCallout 
{
    @future(callout=true)
    public static void payment()
    {
        //********Create a customer *******************
        HTTP h = new HTTP(); 
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://api.stripe.com/v1/customers');
        req.setMethod('POST');
        string token='sk_test_51L8IJTAgRJNLwrDT06ZO9xWB2CO7uEnQ6Vnjmb2BJA9pxGFIorbIm9PiqE7kQ4wTUqP2AhNqSz3ImlRShL67P8Lv00EO5OkBoX';
        req.setHeader('Authorization','bearer '+token);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        string body='description=sameer';
        req.setBody(body);
        
        HTTPResponse res =h.send(req);
        Map<string,Object> customer=(Map<string,object>)JSON.deserializeUntyped(res.getBody());
        system.debug(customer); 
        
        
        //******** Creating  a  Charge *******************
        req.setEndpoint('https://api.stripe.com/v1/charges');
        req.setMethod('POST');
        req.setHeader('Authorization','bearer '+token);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        string body2='amount=100&currency=USD&source=tok_mastercard';
        req.setBody(body2);
        
        HTTPResponse res2 =h.send(req);
        Map<string,Object> charge=(Map<string,object>)JSON.deserializeUntyped(res2.getBody());
        system.debug(charge);
        
        
        
    }
    
}