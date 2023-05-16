public class a2ques6b 
{
    public static void main()
    {
        
        list<sobject>l1=[select rating_given_to_student__r.Student_Name__c, Avg(Rating_out_of_10__c) 
                         from Rating__c group by rating_given_to_student__r.Student_Name__c
                         order by rating_given_to_student__r.Student_Name__c];
        System.debug(l1);
    }

}