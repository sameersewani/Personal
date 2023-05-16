public class a2ques6d 
{
    public static void main()
    {
        list<sobject>l1=[select Name,course__r.Name,course__r.Facuilty_for_thus_course__r.Name from batch__c ];
        system.debug(l1);
    }

}