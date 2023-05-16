public class one
{
    public static void main()
    {
         List<Account> accList=[SELECT name,phone FROM account WHERE  name Like 'A%'];
        integer i = 1;
        for(Account a: accList)
        {
            a.phone= i+' ';
            i+=111;
        }
         update accList;
    }
       
}