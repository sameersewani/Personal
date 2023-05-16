public class a2ques6a 
{
    public static void main()
    {
        list<sobject>l1=[select count(Student_enrolled_in_batch__c),
                       batch_in_which_student_is_enrolled__r.Name from student_in_batch__c 
                       group by batch_in_which_student_is_enrolled__r.Name];
        
        System.debug(l1);
        
        
        
    }

}