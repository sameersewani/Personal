public class ActiveUser 
{
    @AuraEnabled(cacheable=true)
    public static List<User> getActiveUsers() 
    {
        return [SELECT Id, Name FROM User WHERE IsActive = true];
    }
    
    @AuraEnabled(cacheable=true)
    public static Contractor__c getFields(Id i) 
    {
        Contractor__c c=[select FieldName__c from Contractor__c where Owner__c=:i];
        return c;
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String,list<String>> getDescription(List <string> fieldApiNames)
    {
        system.debug(fieldApiNames);
        Map<String,list<String>> demoMap = new  Map<String,list<String>>();
        //List<String> fieldApiNames = new List<String>{'Phone__c', 'Name__c'};
        for (String apiName : fieldApiNames) 
        {
            Schema.DescribeFieldResult fieldDescription = FieldsMeta__c.getsObjectType().getDescribe().fields.getMap().get(apiName).getDescribe();
            
            String LocalName= fieldDescription.getLocalName();
            String Label= fieldDescription.getLabel();
            Integer myInt= fieldDescription.getLength();
            String Length = String.valueOf(myInt);
            Schema.DisplayType  mytype=fieldDescription.getType();
            String typeof = String.valueOf(mytype);               
            list<string> ls=new list<string>{LocalName,Label,Length,typeof};
          
            if(typeof=='PICKLIST')
            {   
                List<Schema.PicklistEntry> P = fieldDescription.getPicklistValues();
                List<String> myArray= new List<String>();
                for(Integer i=0; i<p.size();i++)
                {
                   myArray.add(p[i].getValue());
                }
                String str = String.join( myArray,', ');
                ls.add(str);
            }
            
            demoMap.put(Label,ls);
            
        }
        return demoMap;
        
    }
    
}