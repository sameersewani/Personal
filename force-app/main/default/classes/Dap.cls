public with sharing class Dap
{
@AuraEnabled(cacheable = true)
public static Map<String,String> getAllObjectList()
{ 
    Map<String,String> mapOfAllObject = new  Map<String,String>();
    for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())// it will return name and label
    {
        String name = objTyp.getDescribe().getLocalName();
        String label = objTyp.getDescribe().getLabel();
        mapOfAllObject.put(name,label);
    }   
    return mapOfAllObject;
}


@AuraEnabled(cacheable=true)
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

@AuraEnabled(cacheable=true)
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
    System.debug(slist);
        return slist;
 }

 // to get Account Fields
 @AuraEnabled
 public static List<String> getContactFields()
 {
     SObjectType contactType = Schema.getGlobalDescribe().get('Account');
     Map<String,Schema.SObjectField> mfields = contactType.getDescribe().fields.getMap();

     List<String> sObjectDetailsList = new List<String>();
     for(String s : mfields.keySet())
     {
         sObjectDetailsList.add(String.valueOf(mfields.get(s)));
     }
     return sObjectDetailsList;
 }



}