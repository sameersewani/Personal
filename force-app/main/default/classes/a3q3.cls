public class a3q3 
{
    public static void main()
    {
         
         // Account a= new Account(Name='disney');
        //insert a;
          //Contact c= new Contact(firstname ='sameer',lastname= 'sewani',Accountid=a.id); 
           //insert c;
        
         //List<Account> d3 = [Select name from Account Where name like 'disney'];
        //delete d3;
        
         List<Account> d4 = [Select name from Account Where name like 'disney' and isdeleted=true All Rows ];
        undelete d4;
    }

}