trigger q22 on Opportunity (before insert) 
{
    list<opportunity> oList2= new List <Opportunity>();
    list<opportunity> oList= [select Name,id,AccountId from Opportunity];
    for(Opportunity o1 : Trigger.new)
    {
        for(Opportunity o2 : oList)// old one
        {
            If((o1.Name==o2.Name) && (o1.AccountId==o2.AccountId))
            {
                o2.Name=o2.Name+ 'Duplicate';
                oList2.add(o2);
            }
        }
    }
    update oList2;
}