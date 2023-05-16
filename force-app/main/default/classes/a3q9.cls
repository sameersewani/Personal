public class a3q9 
{
    public static void main(String obj)
    {
        string s = 'Select Id from ' + obj;
        List<Sobject> l1 = database.query(s);
        //System.debug(l1);
        system.debug(l1.size());
        
    }

}