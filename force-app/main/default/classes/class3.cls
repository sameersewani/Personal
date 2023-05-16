public class class3
{
    public static void main()
    {
        List<Integer>l1= new List<Integer>{1,2,3,4,5,6,7,8,9,10};
       
        for (integer i=0; i<5; i++)
       {       
            integer temp = l1.get(0);
            for (integer j =0; j<l1.size()-1; j++)
            {
                l1[j]=l1[j+1];
             
            } 
           l1[l1.size()-1]=temp;
         
        }
      System.debug(l1);
                
    }
}