public class BatchApi  implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful, Schedulable
{
    
     public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([select id,name,Retrived__c,Latitude__c,Longitude__c from whether__c where Retrived__c = false ]);
    }
    
     public void execute(Database.BatchableContext bc, List<whether__c> cityList)
    {
        for(whether__c city  :cityList) 
        {
            Decimal lat = city.Latitude__c;
            Decimal lon = city.Longitude__c;
            
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.openweathermap.org/data/2.5/weather?lat='+lat+'&lon='+lon+'&appid=746895ba3ffa34f4b29d0778c99c7315');
            req.setMethod('GET');
            
            HttpResponse res = h.send(req);
            System.debug(res.getBody());
            
            map<string,object> result = (map<string,object>) JSON.deserializeUntyped(res.getBody());
            system.debug('result - '+result);
            
            map<string,object> res2 = (map<string,object>) result.get('main');
            system.debug(res2);
            
            string visible = string.valueOf(result.get('visibility'));
            string humid = string.valueOf(res2.get('humidity'));
            string maxTemp = string.valueOf(res2.get('temp_max'));
            string minTemp = string.valueOf(res2.get('temp_min'));
            string press = string.valueOf(res2.get('pressure'));
            //system.debug(humid);

        }
    }
    
     public void finish(Database.BatchableContext bc)
    {
        
    }  
    
    public void execute(SchedulableContext sc) 
    {
        BatchApi bWC = new BatchApi();     
        Database.executeBatch(bWC);
    }
    
    // to schedule in anonmus window
    /*
      BatchApi bWH = new BatchApi();
String cronexpression = '0 0 20/2 ? * * *';    //every 2 hrs @8pm
System.schedule('Testing', cronexpression, bWH);
*/
}