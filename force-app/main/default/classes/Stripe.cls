public class Stripe 
{
    @future(callout=true)
    public static void payment(id oliId, string pname,Decimal amt ,String oppName,string email,Integer qnt)
    {
        //********Add Product *******************
           HTTP h = new HTTP(); 
           HTTPRequest req = new HTTPRequest();
           req.setEndpoint('https://api.stripe.com/v1/products');
           req.setMethod('POST');
           string token='sk_test_51L7whNSEBlupgS3S1YHIePp8vMFCjunhR2ZDQM5xyNgf0RWG2ngKp1s2bro9fwbwSOFhkzR6t55PFx8TvERu20hY00poAkEg5S';
           req.setHeader('Authorization','bearer '+token);
           req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
            string body='name=' +pname;
            req.setBody(body);

           HTTPResponse res =h.send(req);
           Map<string,Object> pro=(Map<string,object>)JSON.deserializeUntyped(res.getBody());
           system.debug(pro);
        
        
        
                        //*********** Add price***********
            req.setEndpoint('https://api.stripe.com/v1/prices');
            req.setMethod('POST');
            req.setHeader('Authorization','bearer '+token);
            req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        	string body1='unit_amount='+(integer)amt*100 + '&currency=INR&product=' +pro.get('id');
            req.setBody(body1);
            HTTPResponse res1 =h.send(req);
            Map<string,Object> price=(Map<string,object>)JSON.deserializeUntyped(res1.getBody());
            system.debug(price);
        
        
        
                  //**********Create Payment Link***********
                req.setEndpoint('https://api.stripe.com/v1/payment_links');
                req.setMethod('POST');
                req.setHeader('Authorization','bearer '+token);
                req.setHeader('Content-Type','application/x-www-form-urlencoded');
        
        		string body2='line_items[0][price]=' +price.get('id') +'&line_items[0][quantity]=' +qnt;
                req.setBody(body2);
        		system.debug(qnt);
                HTTPResponse res2 =h.send(req);
        
                Map<string,Object> payment=(Map<string,object>)JSON.deserializeUntyped(res2.getBody());
                system.debug(payment);
        
                string urls=string.valueOf(payment.get('url'));
                system.debug(urls);
        
        
             List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();      
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             List<String> sendTo = new List<String>();
             sendTo.add(email);
             mail.setToAddresses(sendTo);
                 
             mail.setSubject('Payment Link'); //Subject of the mail and the body of the mail
             String bodyy = 'Hello'+oppName+ 'New Product is Added and Payment Link is :'+urls;    
             mail.setHtmlBody(bodyy);
             mails.add(mail);        
             Messaging.sendEmail(mails);
         

        
  
    }

}