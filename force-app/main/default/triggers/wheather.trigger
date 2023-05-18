trigger wheather on Account (after update)
{
    Id i ;
   for(account a :trigger.new)
   {
       i=a.Id;
       Green.GreenAPI(i);
   }
        
}