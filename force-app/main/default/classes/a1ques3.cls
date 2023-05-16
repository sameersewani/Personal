public class a1ques3
{
     public static void main()
    {
        list<integer> l1= new list<integer>{1,2,3,99};
        list<integer> l2= new list<integer>{2,5,3,6,4,1,9};
        list<integer> l3= new list<integer>{9,5,2,3,1,4};
        list<integer> common = new list<integer>();
         
        for(integer i=0; i<l1.size();i++)
        {
            if(l2.contains(l1[i])&& l3.contains(l1[i]))
            {
                common.add(l1[i]);
            }
        }
        system.debug(common);
        system.debug('uu');
    }

}