trigger q7 on Opportunity (after update)
{
    List<Opportunity> opList = new List<Opportunity>();
        
        for(opportunity x: trigger.old)
        {
            Opportunity temp = x.clone(false, false, false, false);
          //temp = x;
            temp.Name += ' Backup';
            System.debug(temp);
            opList.add(temp);
            //System.debug(temp);
        }
        insert opList;
    

}