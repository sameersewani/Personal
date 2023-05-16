public class a2ques6i
{
    public static void  main()
    {
        List<sobject>l1=[select Student_name__c,(select batch_in_which_student_is_enrolled__r.course__r.name from student_in_batches__r),
                         faculty_assigned__r.Name from Student__c 
                          Where (Student_name__c Like 'Kri%' And Faculty_assigned__r.name Like 'Kri%')];
        
        System.debug(l1);
      
        
        
        
    }

}