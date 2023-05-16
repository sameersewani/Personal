public class Opportunityapi 
{
    @future(callout=true)
    public static void OppConvertCurrency(id i)
    {
        Opportunity o = [Select Amount,Amount_in_INR__c from Opportunity where id = :i];
         
            HTTP h = new HTTP();
            HTTPRequest req = new HTTPRequest();
        
            req.setEndpoint('http://data.fixer.io/api/latest?access_key=e5681a22ca9b068ea0f35bc79c9135dc');
            req.setMethod('GET');
        
            HTTPResponse res =h.send(req);
        
            Map<String,Object> jsonBody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            //system.debug(jsonBody);
            Map<String,Object> mMap = (Map<String,Object>)jsonBody.get('rates');
            decimal conversionRate = (decimal)mMap.get('INR');
            o.Amount_In_Inr__c = o.Amount * conversionRate;
           system.debug(o.Amount);
           system.debug(o.Amount_In_Inr__c);
           update o;
        
    }
        
    

}