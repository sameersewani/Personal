@RestResource(urlmapping='/FieldSetApi/')
global class FieldSet 
{

    @HTTPGet
    global static String getinfo()
    {
         String objname;
         ID i;
        
         RestRequest req= RestContext.request;
         RestResponse res= RestContext.response;

        
         i=req.headers.get('Id');
         objname=req.headers.get('ObjectName');
        
        
         String queryString = 'select id';
        
        for(Schema.FieldSetMember fld :SObjectType.Opportunity.FieldSets.GetData.getFields())
        {
         queryString += ', ' + fld.getFieldPath();
        }
        queryString += ' from '+objname+' where ID=:i';
        System.debug(queryString);
        
        Opportunity s = Database.query(queryString);
        system.debug(s);
		String AId=(String)s.get('AccountId');
        System.debug(AId);
        
        
        // -------------------------------------Account------------------------------------------------------
        String queryString1 = 'select id';
        for(Schema.FieldSetMember fld1 :SObjectType.Account.FieldSets.GetDataAccounts.getFields())
        {
            queryString1 += ', ' + fld1.getFieldPath();
        }
        queryString1 += ' from Account Where Id=:AId';
        System.debug(queryString1);  
        
        Account s1 = Database.query(queryString1);
        system.debug(s1);
        

        

        
         // ------------------------------Contact------------------------------------------------------
        String queryString2 = 'select id';
        for(Schema.FieldSetMember fld2 :SObjectType.Contact.FieldSets.GetDataContact.getFields())
        {
            queryString2 += ', ' + fld2.getFieldPath();
        }
        queryString2 += ' from Contact Where AccountId=:AId';
        System.debug(queryString2);  
        
        List<Contact> s2 = Database.query(queryString2);
        system.debug(s2);
        
        string s4='{ "Opportunity": { "Name": "'+s.Name+'" ,"StageName": "'+s.StageName+'","Amount": "'+s.Amount+'"}, "Account":{"Name": "'+s1.Name+'", "AccountEmail": "'+s1.AccountEmail__c+'"} , "Contact":{'+String.valueOf(s2)+'}}';
         return s4;
       
        
         
       
    }
    

}