public class Class2
{
   public static void main()
   {
		String s1 = 'select name from Account';
       String s2=String.escapeSingleQuotes(s1);
        List<sObject> Lst = Database.query(s2);

    }
}