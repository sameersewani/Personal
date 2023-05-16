public class StripeQue 
{
    @future(callout=true)
    public static void payment(Integer amt, Integer oppamt,Id oppid,String name,Id tid)
    {
        //********Create a customer *******************
           HTTP h = new HTTP(); 
           HTTPRequest req = new HTTPRequest();
           req.setEndpoint('https://api.stripe.com/v1/customers');
           req.setMethod('POST');
           string token='sk_test_51L8IJTAgRJNLwrDT06ZO9xWB2CO7uEnQ6Vnjmb2BJA9pxGFIorbIm9PiqE7kQ4wTUqP2AhNqSz3ImlRShL67P8Lv00EO5OkBoX';
           req.setHeader('Authorization','bearer '+token);
           req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
            string body='description='+name;
            req.setBody(body);

           HTTPResponse res =h.send(req);
           Map<string,Object> customer=(Map<string,object>)JSON.deserializeUntyped(res.getBody());
           system.debug(customer); 
        	
        	String customerId=(String)customer.get('id');
            system.debug(customerId);
        
        
        
        //********Create a card *******************
        
           req.setEndpoint('https://api.stripe.com/v1/customers/'+customerId);
           req.setMethod('POST');
           req.setHeader('Authorization','bearer '+token);
           req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
            string body1='source=tok_visa';
            req.setBody(body1);

           HTTPResponse res1 =h.send(req);
           Map<string,Object> card=(Map<string,object>)JSON.deserializeUntyped(res1.getBody());
           system.debug(card); 
       
        
        
             
        
         //******** Creating  a  Charge *******************
           req.setEndpoint('https://api.stripe.com/v1/charges');
           req.setMethod('POST');
           req.setHeader('Authorization','bearer '+token);
           req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
            string body2='amount='+(Integer)amt+ '&currency=USD&customer='+customerId;
            req.setBody(body2);

           HTTPResponse res2 =h.send(req);
           Map<string,Object> charge=(Map<string,object>)JSON.deserializeUntyped(res2.getBody());
           system.debug(charge);
        	
        	Integer am=(Integer)charge.get('amount');
            system.debug(am);
        

 
        	Map<string,Object> Demo=(Map<string,Object>)charge.get('outcome');
        	System.debug(Demo);
       
            Opportunity op=[select amount from Opportunity where id=:oppid];
        	system.debug(op);
            op.Amount=  op.Amount-am;
            update op;
        	system.debug(op);
        
        	Transactionn__c t=[select id from Transactionn__c where id=:tid];
        	system.debug(t);
        	
        	t.PaymentID__c=(String)charge.get('id');
        	t.TransactionError__c=(String)Demo.get('network_status');
        	t.CardNumber__c=(Integer)charge.get('created');
 
        	update t;
            system.debug(t);
    }

}