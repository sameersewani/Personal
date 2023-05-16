public class a3q1
{
    public static void main()
    {
        list<student__c>l1=[select Student_Name__c from student__c where Student_Name__c like 's%'];
        integer i=1;
        for(student__c s: l1)
        {
            s.Student_Name__c=s.Student_Name__c+'test'+i;
            i++;
        }
        update l1;
       // system.debug(l1);
    }

}