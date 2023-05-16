public class a3q5b
{
    public static void main()
    {
        Date d1 = Date.newInstance(2018, 05, 01);
        Date d2 = Date.newInstance(2018, 05, 30);
      list<Student__C>l1 =[select Student_Name__c from Student__C where(LastModifiedDate  >= :d1 AND LastModifiedDate <= :d2) 
                           and isdeleted= true all rows];
        undelete l1;
        
      
    }

}