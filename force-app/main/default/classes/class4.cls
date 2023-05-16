public class class4
{
    public static void main()
    {
          List<Integer>l1= new List<Integer>{1,2,3,4,5};
          List<Integer>l2= new List<Integer>{1,2,3,7,8};
          Set<Integer>l3= new Set<Integer>();
        l3.addall(l1);
        l3.retainAll(l2);
        System.debug(l3);
        
    }
    

}