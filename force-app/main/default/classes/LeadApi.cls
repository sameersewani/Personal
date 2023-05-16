@RESTResource(urlMapping='/LeadCreate/')
global class LeadApi
{
    @HTTPGet
    
    global static String ShowLead()
    {
        String objname;
        ID i;
        
         RestRequest req= RestContext.request;
         RestResponse res= RestContext.response;

         objname=req.headers.get('ObjectName');
         i=req.headers.get('Id');
        
        String qr='select name from '+objname+' where ID=:i ' +'Limit 1';
        sObject s=Database.query(qr);
        String jsonResponse = '{\"name\":\"'+s.get('name')+'\"}';
        return jsonResponse;
        
    }
 
    @HTTPPost
    global static String CreateLead()
    {
        String fname,lname,comp,st,fieldname,fieldvalue;
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
                
                if(fieldname=='firstname')
                {
                    fname=fieldvalue;
                }
                else if(fieldname=='lastname')
                {
                    lname=fieldvalue;
                }
                else if(fieldname=='company')	
                {
                    comp=fieldvalue;
                }
                else if(fieldname=='Status')
                {
                    st=fieldvalue;
                }
                
            }
        }
        
        Lead l=new Lead(firstname=fname,lastname=lname,company=comp,Status=st);
        insert l;
        return l.id;
        
    }

}