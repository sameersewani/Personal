public with sharing class Task3
 {
    // To get child objects
    @AuraEnabled
    public  static List<String> getChildName(String objectName)
    {
        String myString = objectName;
       SObjectType sObjType = ((SObject) Type.forName(myString).newInstance()).getSObjectType();
        
      List<String> ChildObjectName = new  List<String>();
        Schema.DescribeSObjectResult R =sObjType.getDescribe();
	
        for (Schema.ChildRelationship cr: R.getChildRelationships())
        {
            system.debug(String.valueOf(cr.getChildSObject()));
            ChildObjectName.add(String.valueOf(cr.getChildSObject()));
        
        }
        return ChildObjectName;
    }

    // to get fileds
    @AuraEnabled
    public static Map<String,String> getAllPicklistTypeFields(String strAccountName) 
    {
        Map<String, Schema.SObjectType> detail = Schema.getGlobalDescribe();

        Map<String,String> mapOfPicklistTypeFields = new  Map<String,String>();
        
        for(Schema.SObjectField fields :detail.get(strAccountName).getDescribe().fields.getMap().Values())
            {
                mapOfPicklistTypeFields.put(fields.getDescribe().getName() , fields.getDescribe().getName());
            
        }
        return mapOfPicklistTypeFields;
    }   

    // to get data relted to fileds and object
    @AuraEnabled
    public static List<SObject> getdata(String objectName, List<String> fieldlist)
    {
        
            String ans = '';
            for(integer i=0; i<fieldlist.size(); i++)
            {
                if(i==fieldlist.size()-1)
                {
                    ans+=fieldlist[i];
                }
                else
                {
                    ans+=fieldlist[i]+',';
                }
            }
        String q='select ' +ans+' from '+objectName;
        system.debug(q);

        List <sobject> slist=Database.query(q); 
        return slist;
    }

    // To get Perent Object
    @AuraEnabled
    public static  List<String> getDetails(String objectName)
    {
        String myString = objectName;
       SObjectType sObjType = ((SObject) Type.forName(myString).newInstance()).getSObjectType();
        
        List<String> ChildObjectName = new  List<String>();
         for(Schema.SobjectField strFld: sObjType.getDescribe().fields.getMap().Values())
         {
               if(strFld.getDescribe().getType() == Schema.DisplayType.REFERENCE)
               {
               system.debug(String.valueOf(strFld.getDescribe().getReferenceTo()));
               ChildObjectName.add(String.valueOf(strFld.getDescribe().getReferenceTo()));
               }
         }
        return ChildObjectName;
    }

    // to get data from apex
    @AuraEnabled
    public static List<Sobject> getOwner(String objectName)
    {
         String q='select Name,owner.name from '+objectName;
         system.debug(q);
        
       List <sobject> slist=Database.query(q);
        system.debug(slist);
       return slist;
    }


   
}