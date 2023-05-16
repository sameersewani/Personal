public with sharing class CustomFileUpload 
{
    @AuraEnabled
    public static List<ContentVersion> getdata(Id Conid,list<id> idcv)
    {
        List<ContentVersion> result = [select title,id,ContentDocumentId  from ContentVersion where id=:idcv];  
        for(contentversion cv:result)
        {
            cv.Contact__c=Conid;
        }
        update result;
      return result;
    }

    @AuraEnabled
    public static List<ContentVersion> getdata1(Id recid)
    {
        List<ContentVersion> result1 = [select title,id,Contact__c,ContentDocumentId,FileExtension,FileType,LastModifiedDate,Owner.Name from ContentVersion where Contact__c=:recid];
        return result1;
    }
}