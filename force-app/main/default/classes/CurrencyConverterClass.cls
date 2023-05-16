public class CurrencyConverterClass
{
 
    public static Decimal convertCurrencyToINR(Decimal Eur)
    {
        Decimal inr = 0.0;
        HTTP h= new HTTP();
        HTTPRequest req =  new HTTPRequest();
        
        req.setEndpoint('http://data.fixer.io/api/latest?access_key=e5681a22ca9b068ea0f35bc79c9135dc');
        req.setMethod('GET');
        
        HTTPResponse res=h.send(req);
        System.debug(res);// it will return Status=OK, StatusCode=200]
       
        Map<String,Object> jsonBody= (Map<String,Object>)Json.deserializeUntyped(res.getBody());
        System.debug(jsonBody);

        Map<String,Object> mMap= (Map<String,Object>) jsonBody.get('rates');
        System.debug(mMap);
        Decimal conversionRate= (Decimal) mMap.get('INR');
        System.debug(conversionRate);
        inr = Eur * conversionRate;
        system.debug(inr);
        return inr;
    }
}