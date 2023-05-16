public with sharing class VFcallout 
{
    public String response {get;set;}
    
    public void makeCallout() 
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.stripe.com/v1/customers');
        request.setMethod('POST');
        string token='sk_test_51L8IJTAgRJNLwrDT06ZO9xWB2CO7uEnQ6Vnjmb2BJA9pxGFIorbIm9PiqE7kQ4wTUqP2AhNqSz3ImlRShL67P8Lv00EO5OkBoX';
        request.setHeader('Authorization','bearer '+token);
        
        string body='name=Sameer';
        request.setBody(body);
        HttpResponse httpResponse = http.send(request);
        response = httpResponse.getBody();
    }


}