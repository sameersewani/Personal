public class a3q6 
{
    public static void main()
    {
        Account a = new Account(external_id__c='mnopp');
        Contact c= new Contact(firstname ='sameer',lastname= 'sew');
        c.Account=a;
        Account acclist = new Account(external_id__c='mnopp',name='sameer');
        database.insert(new sobject[]{acclist,c});
         
        
        
        
    }

}