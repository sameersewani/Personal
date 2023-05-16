public class a2ques6e 
{
    public static void main()
    {
        AggregateResult ar7=[select count_distinct(Student_Name__c)from student__C];
            system.debug(ar7);
        
    }

}