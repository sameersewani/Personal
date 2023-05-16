public class a2ques2
{
    public static void main(String FirstDate,String LastDate)
    {
        Date d1=Date.valueOf(FirstDate);
        Date d2=Date.valueOf(LastDate);
        List<Opportunity> ol=[Select name from opportunity where(closeDate>=:d1 And closeDate<=:d2) And Owner.Name='sameer sewani'];
         for(Opportunity o:ol)
         {
           System.debug(o.Name);
        
         }
    }
        

}