public with sharing class DemoPwd 
{
    public DemoPwd() 
    {
        
    }
     public void method1(Integer a,Integer b)
    {
        System.debug('Hello wrd');
        for(Integer i=0; i<10; i++)
        {
            Account a=[select id from Account];
        }
    }
}