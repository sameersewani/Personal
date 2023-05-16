public class CyberSource 
{
    public static void main()
    {
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://apitest.cybersource.com/pts/v2/payments');
        req.setMethod('POST');
        String body = '{"clientReferenceInformation":{"code":"TC50171_3"},"paymentInformation":{"card":{"number":"4111111111111111","expirationMonth":"12","expirationYear":"2031"}},"orderInformation":{"amountDetails":{"totalAmount":"102.21","currency":"USD"},"billTo":{"firstName":"John","lastName":"Doe","address1":"1 Market St","locality":"san francisco","administrativeArea":"CA","postalCode":"94105","country":"US","email":"test@cybs.com","phoneNumber":"4158880000"}}}';
        String demoJSON = JSON.serialize(body);
		System.debug(demoJSON);
        req.setBody(demoJSON);  
        
        req.setHeader('v-c-merchant-id', 'cyntexa123');
        req.setHeader('Content-Type', 'application/json;');
        req.setHeader('date', 'Tue, 14 Mar 2023 05:28:32 GMT');
        req.setHeader('host', 'apitest.cybersource.com');
        req.setHeader('digest', 'SHA-256=1wk5Hls1qcbZtjYDldGyl3B2i92v4rOqXyx6twRboEs=');
        req.setHeader('signature', 'keyid="7403555a-08dc-4be0-a9d3-07d25f693b91", algorithm="HmacSHA256", headers="host (request-target) digest v-c-merchant-id", signature="vVUJ0KHKzE6IWsjd31Agkkul8/8mec85FeN2ksskJzM="'); 	
        
        HTTPResponse res =h.send(req);  
        system.debug('Body '+res.getBody());
        system.debug('StatusCode '+res.getStatusCode());
                
        //Map<String,Object> jsonBody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        //system.debug(jsonBody);
    }

}