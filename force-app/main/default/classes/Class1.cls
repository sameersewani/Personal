public class Class1
{
	public static void main()
    {
        List<Bank__c> l1=[Select Name from Bank__c];
        for(Integer i=0; i<l1.size(); i++)
        {
            System.debug(l1[i].Name);
        }
            
        
    }
}