@RestResource(urlMapping='/WebhooksDemo/*')
global class WebhookTst 
{
    @HttpPost
    global static String Twoway()
    {
       /* RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String str=req.requestBody.toString();
        system.debug('str -->'+str);
        Account acc=[select Description from Account where id='0015j00000mVBq7AAG'];
        //acc.Description='hh';
        acc.Description=str;
        
  
        QuickbookWrapper wrap=(QuickbookWrapper)JSON.deserialize(str, QuickbookWrapper.class);
        String AccId=wrap.eventNotifications[0].dataChangeEvent.entities[0].id;
        acc.external_id__c=AccId;
        system.debug('AccId -->'+AccId);
         
        
        update acc;*/
        return 'sameer';
    }

}