public class HotelApi 
{
    @future (callout=true)
    public static void getHotels(String state)
    {
        List<Hotel__c> c=[select Name,Latitude__c,Longitude__c from Hotel__c];
        City__c city=[select id,name from City__c where name=:state];
        system.debug(city);
        List<Hotel__c> clist=new List<Hotel__c>();
        Http http=new Http();
        HttpRequest request= new HttpRequest();
        request.setEndPoint('https://hotels4.p.rapidapi.com/locations/v2/search?query='+state+'&locale=en&currency=INR');
        request.setHeader('X-RapidAPI-Key','9b4002c4e2mshd7aa7a31f0a08d9p1e2148jsnc050cf6811ba');
        request.setHeader('X-RapidAPI-Host','hotels4.p.rapidapi.com');
        request.setMethod('GET');
        HttpResponse response=http.send(request);
        system.debug(response);
        
        HotelWrapper wrap=(HotelWrapper)JSON.deserialize(response.getBody(), HotelWrapper.class);
			system.debug(wrap);	
		    //System.debug(wrap.suggestions[1].entities[1].name);

			for(Integer i=0;i<wrap.suggestions[1].entities.size(); i++)
            {
                system.debug(wrap.suggestions[1].entities[i].name);
                
                  Hotel__c cc= new Hotel__c();
                    cc.Name=wrap.suggestions[1].entities[i].name;
                    cc.Latitude__c=wrap.suggestions[1].entities[i].latitude;
                    cc.Longitude__c =wrap.suggestions[1].entities[i].longitude;    
                    clist.add(cc);
                    cc.City__c=city.id;
                system.debug(cc);
            }
        insert clist;
        
        
    }

}      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /*
        Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        system.debug(results);
        
        List<Object> result1 = (List<Object>)results.get('suggestions');
        System.debug(result1);
        
        for(Object abc : result1)
        {
            Map<String,Object> result2 = (Map<String,Object>)abc;
            //System.debug(result2);
            String result3 =(String)result2.get('group');
            //system.debug(result3);
            
            if(result3=='HOTEL_GROUP')
            {
                Map<String,Object> result4 = (Map<String,Object>)abc;
                system.debug(result4);
                
                 List<Object> result5 = (List<Object>)result4.get('entities');
                 System.debug(result5);
                
                for(Object abc2 : result5)
                {
                    Map<String,Object> result6 = (Map<String,Object>)abc2;
                    system.debug(result6);
                    Decimal lati=(Decimal)result6.get('latitude');
                    system.debug(lati);
                    Decimal longi=(Decimal)result6.get('longitude');
                    system.debug(longi);
                    
                    String name=(String)result6.get('name');
                    system.debug(name);
                    
                    Hotel__c cc= new Hotel__c();
                    cc.Name=name;
                    cc.Latitude__c=lati;
                    cc.Longitude__c =longi;       
                    clist.add(cc);
                    cc.City__c=city.id;
    
                }
            }      
        }
        insert clist;   */