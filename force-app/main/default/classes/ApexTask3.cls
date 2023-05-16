public class ApexTask3 
{
    public static void mymethod(List<Loan_Entity__c> Entity)
    {
        List<Loan__c> Lname=[select id,name from Loan__c];
        //List<Loan_Entity__c> EntityName=[select name,Loan_Amount__c,Loan__c,Borrower_Type__c from Loan_Entity__c];
        list<Loan_Entity__c> newList=new list<Loan_Entity__c>();
        
        Decimal total;
        Integer count;
        for(Loan__c l :Lname)
            {
                system.debug(l.Name);
                count=0;
                total=0;
                for(Loan_Entity__c le: Entity)
                {            
                     if(l.Id==le.Loan__c && le.Borrower_Type__c=='Co-Borrower')
                    {
                        count++;
                    }					                    
                    if(l.Id==le.Loan__c)
                    {
                       total+=le.Loan_Amount__c;
                        if(total<=50000)
                        {
                           if(count<=3)
                           {
                              newList.add(le); 
                           }   
                            else
                            {
                                le.addError('you cant add more records');
                            }
                        }
                        
                    }

                } 
                system.debug('count--'+count);
			    system.debug('total--'+total);
            }
         
    }

}