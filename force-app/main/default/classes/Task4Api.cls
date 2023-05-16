@RESTResource(urlMapping='/Task/')
global class Task4Api 
{
    @HTTPPost
    global static List<String> CreateData()
    {
        // Variables for Mail Header
         String fieldname,fieldvalue,name,Ec,Es,P;
          //DateTime Dr,fieldvalue1;
        
        // Variables for Mail Chain
         String Dt,Fr,To,Cc,Bcc,Sub,Eb,MailHeader;
             
             
        RestRequest req= RestContext.request;
        RestResponse res= RestContext.response;
        
        String jsonbody= req.requestBody.toString();
        JSONParser parser = JSON.createParser(jsonbody);
        
        while(parser.nextToken()!=null)
        {
            if(parser.getCurrentToken()!=JsonToken.END_OBJECT)
            {
                fieldname=parser.getCurrentName();
                fieldvalue=parser.getText();	
                //fieldvalue1=parser.getDatetimeValue();
               
                
                if(fieldname=='Name')
                {
                    name=fieldvalue;
                }
                else if(fieldname=='Email_Category__c')
                {
                    Ec=fieldvalue;
                  
                }
                else if(fieldname=='Email_Subject__c')
                {
                  Es=fieldvalue;
                }
                else if(fieldname=='Priority__c')
                {
                 P=fieldvalue;
                }
                /*else if(fieldname=='Date_Received__c')
                {
                   Dr=fieldvalue1;
                }
                else if(fieldname=='Date_and_Time_of_Email__c')
                {
                   Dt=fieldvalue;
                }*/
                else if(fieldname=='From__c')
                {
                   Fr=fieldvalue;
                }
                else if(fieldname=='To__c')
                {
                   To=fieldvalue;
                }
                else if(fieldname=='CC__c')
                {
                   Cc=fieldvalue;
                }
                else if(fieldname=='Subject__c')
                {
                   Sub=fieldvalue;
                }
                else if(fieldname=='Email_Body__c')
                {
					Eb=fieldvalue;                   
                }
                else if(fieldname=='BCC__c')
                {
                   Bcc=fieldvalue;
                }
                else if(fieldname=='Mail_Header__c')
                {
                   MailHeader=fieldvalue;
                }
                               
            }
        }
        List<String> ids= new List<String>();
         if(name != null &&(Ec != null || Es!= null || P!=null /*|| Dr!= null*/))
         {
             Mail_Header__c mh=new Mail_Header__c(Name=name, Email_Category__c=Ec, Email_Subject__c=Es, Priority__c=P/*, Date_Received__c=Dr*/);
             insert mh;
             ids.add(mh.Id);
             
         }
        if(name != null &&(/*Dt != null ||*/ Fr!= null || To!=null || Cc!= null || Sub!=null || Bcc!=null))
        {
            Mail_Chain__c mc= new Mail_Chain__c(Name=name, /*Date_and_Time_of_Email__c=Dt,*/ From__c=Fr, To__c=To, CC__c=Cc, Subject__c=Sub, BCC__c=Bcc, Mail_Header__c=MailHeader);
        	  insert mc;
             ids.add(mc.Id);
        }          
        return ids;
    
    }

}