public class class5
{
    public static void main()
    {
        
        List<Integer>l2= new List<Integer>{1,2,3,4,5,6,7,8,9,10};   
        for(integer i =0; i<5; i++)
         {
            integer temp = l2[l2.size()-1];
            for(integer j =l2.size()-1; j>0;j-- )
            {
                l2[j] = l2[j-1];
            }    
            l2[0] = temp;
        }
        System.debug(l2);
    }
}