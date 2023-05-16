public class a1ques4 
{
     public static void mymethod()
    {
        list<integer> l = new list<integer>{149,1,3,248,2,8,70,5,1,4};
        list<integer> leaders=new list<integer>();
        boolean flag;
        for(integer i=0;i<l.size();i++)
        {
            for(integer j=i+1;j<l.size();j++)
            {
                flag=false;
                if(l[i]>=l[j])
                {
                   flag= true; 
                }
                else
                {
                    flag= false;
                    break;
                }
            }
            if(flag==true)
            {
                leaders.add(l[i]);
            }
        }
        system.debug(leaders);
    }

}