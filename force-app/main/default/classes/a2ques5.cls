public class a2ques5 
{
    public static void main()
    {
        List<Account> accList = [Select name, (Select name from Opportunities) , (Select name From Contacts), 
                                 (select title, body from Notes) From Account WHERE name Like 'B%'];      
         
        Map<Id,sObject> myMap = new Map<id,sObject>();
        
        for(Account a:accList)
        {
            for(Opportunity o: a.Opportunities)
            {
                myMap.put(o.id,o);
            }
            for(Contact c: a.Contacts)
            {
                myMap.put(c.id,c);
            }
            for(Note n: a.Notes)
            {
                myMap.put(n.id,n);
            }
        }
        
        for(String key:myMap.keySet())
        { 
            System.debug(key + ' => ' + myMap.get(key));
        }
    }
}