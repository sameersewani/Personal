public class a2ques6h 
{
    public static void main()
    {
        list<String>acclist= new List<String>{'anand','pawan','Daan'};
        list<sobject>l1=[select Student_Name__c from Student__c where Student_Name__c IN :acclist And Joining_date__c=THIS_FISCAL_QUARTER ];
        system.debug(l1);
        
    }

}