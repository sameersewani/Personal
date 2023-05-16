public with sharing class Task1
 {
    @AuraEnabled
    public static List<ContentVersion> getdata(Id oppid,list<id> idcv)
    {
        List<ContentVersion> result = [select title,id,ContentDocumentId  from ContentVersion where id=:idcv];  
        for(contentversion cv:result)
        {
            cv.OpportunityId__c=oppid;
        }
        update result;
      return result;
    } 
    

    @AuraEnabled
    public static List<ContentVersion> getdata1(Id recid)
    {
        List<ContentVersion> result1 = [select title,id,OpportunityId__c,ContentDocumentId,FileExtension,FileType from ContentVersion where OpportunityId__c=:recid];
      return result1;
    }

    @AuraEnabled
    public static void sendEmail(Id verId)
    {
      ContentVersion con=[select id,contentdocumentid,FileExtension,FileType,versiondata,opportunityid__c,title from contentversion where id=:verId];
      id temp = con.opportunityid__c;
      String oppEmail=[select Emai__c from opportunity where id=:temp].emai__c;

      Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
      efa.setFileName(con.title);
      efa.setBody(con.versiondata);
      if(con.FileExtension=='pdf')
      { 
        efa.setContentType('application/pdf');

      }
      else if(con.FileType=='JPEG' || con.FileType=='JPG')
      { 
        efa.setContentType('image/jpeg');

      }
      else if(con.FileExtension=='doc')
      { 
        efa.setContentType('application/msword');

      }
      else if(con.FileExtension=='docx')
      {
        efa.setContentType('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
      }

          
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      list<String> emailAddr = new list<String>();
      emailAddr.add(oppEmail);
      mail.setToAddresses(emailAddr);
      mail.setPlainTextBody('Here is your file');
     
      mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
      Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }




}