trigger Customer on Account (after insert,after update)
{
   for (Account a:trigger.new)
    {
        QuickbookCustomer.setCustomer(a.id);
        
    }
}