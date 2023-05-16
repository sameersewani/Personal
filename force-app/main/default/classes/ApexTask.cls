public class ApexTask
{
    static  integer temp=0;
    public static void main(List<Lead> llist)
    {	
        list<lead> ExistingLead=[select id,lastname from lead where id =:llist];
      	system.debug(ExistingLead);
        list<lead> DuplicateLead= new list<lead>();
        
        
        
         integer index=0;
        list<CustomUser__c> Cuser=[select id,ratio__c from CustomUser__c order by createddate];
        
        for(CustomUser__c u : Cuser)
            {
                index+=(integer)u.ratio__c;
            }
        system.debug('index '+index);
        system.debug('size '+llist.size());
 
        
        
        for(integer i=0;i<Cuser.size();i++)
        {        
            for(integer j=0;j<Cuser[i].ratio__c;j++)
            {
                if(temp<llist.size())
                {
                    llist[temp].CustomUser__c=Cuser[i].id;
                    temp++;
                    if(temp>=index)
                    {
                        myfunction(llist,cuser);
                    }
                }               
            } 
            
         }
        
        
    }
    	
     public static void myfunction(List<Lead> llist2, list<CustomUser__c> cuser2)
     {

        for(integer i=0;i<cuser2.size();i++)
        {        
            for(integer j=0;j<cuser2[i].ratio__c;j++)
            {
                if(temp<llist2.size())
                {
                    llist2[temp].CustomUser__c=cuser2[i].id;
                    temp++;                   
                }               
            } 
            
         }
      }
}