public class dd 
{
    public static void mymethod()
    {
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple)
            {
                pickListValuesList.add(pickListVal.getLabel());
            }     
        system.debug(pickListValuesList);
            
     }

}