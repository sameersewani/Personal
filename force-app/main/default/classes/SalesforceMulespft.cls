public class SalesforceMulespft 
{
    @future(callout=true)
    public static void getData()
    {
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://3c7e-202-131-122-186.ngrok-free.app/accounts');
        req.setMethod('GET');
        //req.setHeader('Content-Type', 'application/json');
        
        HTTPResponse res =h.send(req);
       	system.debug('res'+res.getBody());
    }
    
}