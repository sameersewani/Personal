public class Green
{
 	@future (callout=true)
    public static void GreenAPI(Id i)
    {
            Http http=new Http();
            HttpRequest request= new HttpRequest();
            request.setEndPoint('https://api.openweathermap.org/data/2.5/weather?q=Ulverston&APPID=6a4199d8698bb67cc604e3fb8082599d');
            request.setMethod('GET');
            HttpResponse response=http.send(request);
        
 			Map<String,Object> results=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        	system.debug(results);
        
            list<object> llist = (list<object>)results.get('weather');
            system.debug(llist[0]);
        
            map<string,object> m = (map<string,object>)llist[0];
            system.debug(m.get('description'));
        
        	account ac = [SELECT Id,Description from account where Id =:i LIMIT 1];
            ac.Description=(string)m.get('description');
        update ac;
      
      }
        
    
}