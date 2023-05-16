public class a2ques6c 
{
    public static void main()
    {
        List<Student__c>l1=[select Student_Name__c from Student__c where Student_Name__c like '%aa%' ];
        system.debug(l1);
        
    }

}