public class a3q5
{
    public static void main()
    {
        list<Student__C>l1 =[select Student_Name__c from Student__C where Student_Name__c like '_r%'];
        delete l1;
        list<Student__C>l2 =[select Student_Name__c from Student__C where isdeleted=true All Rows];
        Database.emptyRecycleBin(l2);
        
        
        
     }

}