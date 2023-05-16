public with sharing class CSV 
{
    @AuraEnabled
    public static List<List<String>> csvFileRead(Id contentDocumentId)
    {
        
        ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId ];
        List <String> records = contentVersionObj.VersionData.toString().split( '\n' );

        List<List<String>> rows = new List<List<String>>();

        for(Integer i = 0; i<records.size(); i++)
        {
            list<String> csvRowData = records[i].split(',');
            rows.add(csvRowData);
            System.debug('csvRowData====> '+csvRowData);
        
        }
        return rows;
    }
}