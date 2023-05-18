trigger QRTrigger on Lead (after insert)
{
   
    List<Account> acc=[select Id, Name, Phone from account];
    List<Lead> llist=[select LastName,Phone,Company from lead where id In:trigger.new];
    for(Lead l : llist)
    {
        for(Account ac : acc)
        {
            if(l.LastName == ac.Name)
            {
                l.Account__c = ac.Id; 
                QR.main(l.Id);
            }
            else
            {
                l.Status = 'Closed - Not Converted';
            }
        }
        
    }
    system.debug(llist);
    update llist;
}