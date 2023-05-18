trigger FutureOpp on Opportunity (after insert)
{
     @future(callout=true)
    public static void ConvertCurrencyToINR(Decimal usd)
    {
        Decimal inr=0.0;
        HTTP h=new HTTP();
        HTTPRequest req= new HTTPRequest();
        
         req.setEndpoint('http://data.fixer.io/api/latest?access_key=e5681a22ca9b068ea0f35bc79c9135dc');
          req.setMethod('GET');
        
        HTTPResponse res=h.send(req);
        System.debug(res);
        
        Map<String,Object> jsonBody=(Map<String,Object>)Json.deserializeUntyped(res.getBody());

        Map<String,Object> mMap=(Map<String,Object>) jsonBody.get('results');
        
        Map<String,Object> mMap2=(Map<String,Object>) mMap.get('USD_INR');
        
        Decimal conversionRate= (Decimal) mMap2.get('val');
        inr = usd * conversionRate;
        //System.debug('inr');
    }

}









/*list<Opportunity> oppList = new List<Opportunity>();
        for(opportunity o:Trigger.new)
        {
            if(o.Amount_In_Inr__c == null)
            { 
                o.Amount=25000;
                oppList.add(o);
            }
        }
        update oppList;*/