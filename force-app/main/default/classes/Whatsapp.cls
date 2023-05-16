public class Whatsapp 
{
    public static void main()
    {
        Contact con = [Select Id,Phone from Contact where id ='0035j00000qo35oAAA'];
        
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://graph.facebook.com/v15.0/102172196141067/messages');
        req.setMethod('POST');
        String body = '{"messaging_product":"whatsapp","to":"'+'91'+con.Phone+'","type":"template","template":{"name":"hello_world","language":{"code":"en_US"}}}';
        req.setBody(body);  
        
        String apiToken='EAAMZCZBj584MMBAOaZAk6mGh6xAa0uwbE1f54zekhZAQFcXvO1YZCvTA5J3eFSxbLZBjt3ZBeDWJ4uzM17kxyGLpFRg9FhAeegJe9pFbM4biVsdr3qp1bjVQq2vEZAYD6WjRmsp0131uugawF7EdJX8PGIICOJyWdW69sdTHtIZCtb4TgFy53rgq9DyA0tiwI19303trC4hp5ogZDZD';
        req.setHeader('Authorization', 'Bearer '+apiToken);
        req.setHeader('Content-Type', 'application/json');
        
        HTTPResponse res =h.send(req); 
        
        system.debug('Body '+res.getBody());
        system.debug('StatusCode '+res.getStatusCode());
                
        Map<String,Object> jsonBody = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        system.debug(jsonBody);
    }
    
}