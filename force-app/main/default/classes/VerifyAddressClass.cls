public with sharing class VerifyAddressClass 
{
    @AuraEnabled(cacheable = true)
    public static Map<String,String> getAddressTypeFields(String strObjectName)
    {
        Map<String, Schema.SObjectType> detail = Schema.getGlobalDescribe();
        Map<String,String> mapOfAddressTypeFields = new  Map<String,String>();
        for(Schema.SObjectField fields :detail.get(strObjectName).getDescribe().fields.getMap().Values()) 
        {
            If(fields.getDescribe().getType() == Schema.DisplayType.ADDRESS) 
            { 
                mapOfAddressTypeFields.put(fields.getDescribe().getName(),fields.getDescribe().getName());
                system.debug(mapOfAddressTypeFields);
            }
        }
        return mapOfAddressTypeFields;
    }
    
    @AuraEnabled
    public static string  getFieldValue(String objectName,String fieldname,String recordId) 
    {
        String res;
        recordId='\''+recordId+'\'';
        system.debug(recordId);
        String q='select ' +fieldname+' from '+objectName+ ' where Id='+recordId;
        system.debug(q);
        
        SObject slist=Database.query(q); 
        System.debug(slist);
        
        string lsstr=String.valueOf(slist);
        List<String> strListStr = lsstr.split(':');
        system.debug(strListStr[0]);
        if(strListStr[0]=='Account') 
        {
            Account a = (Account)slist;        
            //Object name = slist.get(fieldname);
            //system.debug(name);
            System.Address temp = (System.Address)slist.get(fieldname);
            system.debug(temp.getStreet());
            res=temp.getStreet()+','+temp.getCity()+temp.getState()+','+temp.getPostalCode()+','+temp.getCountry();       
        }
        if(strListStr[0]=='Contact')
        {
            Contact c = (Contact)slist;
            System.Address temp = (System.Address)slist.get(fieldname);
            system.debug(temp.getStreet());
            res=temp.getStreet()+','+temp.getCity()+temp.getState()+','+temp.getPostalCode()+','+temp.getCountry();
        }
        if(strListStr[0]=='Lead')
        {
            Lead l = (Lead)slist;
            System.Address temp = (System.Address)slist.get(fieldname);
            system.debug(temp.getStreet());
            res=temp.getStreet()+','+temp.getCity()+temp.getState()+','+temp.getPostalCode()+','+temp.getCountry();
        } 
        return res;
    }
    
    @AuraEnabled
    public static SObject UpdateValue(String objectName,String fieldname,String recordId,String upAddress)
    {
        String demo;
        recordId='\''+recordId+'\'';
        system.debug(recordId);
        String q='select ' +fieldname+' from '+objectName+ ' where Id='+recordId;
        system.debug(q);
        
        sobject slist=Database.query(q); 
        System.debug(slist);
        
        string lsstr=String.valueOf(slist);
        List<String> strListStr = lsstr.split(':');
        system.debug(strListStr[0]);
        
        if(strListStr[0]=='Account')
        {
            Account a =(Account)slist;
            System.Address temp = (System.Address)slist.get(fieldname);
            a.put('BillingStreet',upAddress);
            update a;
            system.debug(a);
            
        }
        else if(strListStr[0]=='Contact')
        {
            Contact c = (Contact)slist;
        }
        else if(strListStr[0]=='Lead')
        {
            Lead l = (Lead)slist;
        }
        
        return slist;
    }
    
    @AuraEnabled
    public static  string fetchapi(String address)
    {
        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.postgrid.com/v1/intl_addver/verifications?includeDetails=true');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('x-api-key', 'live_sk_mroGFAEfdkXfpiXUnjGJx');
        request.setMethod('POST');
        String body ='address='+address;
        System.debug('Body in getAccessToken: '+body);
        request.setBody(body);   
        
        HttpResponse response = h.send(request);
        System.debug('Response in getRefreshToken:'+response);
        
        Map<string,Object> result=(Map<string,object>)JSON.deserializeUntyped(response.getBody());
        system.debug(result);
        
        Map<string,Object> result1=(Map<string,object>)result.get('data');
        system.debug(result1);
        
        String updatedAddres=(string)result1.get('formattedAddress');
        system.debug(updatedAddres);
        
        return updatedAddres;
    }
    
}