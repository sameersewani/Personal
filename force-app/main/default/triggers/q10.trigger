trigger q10 on OpportunityLineItem (before insert)
{
    List<Product2> prdtList = [Select Description from Product2];
    for(OpportunityLineItem oli : trigger.new)
    {
         if(oli.ListPrice > 10000)
         {
             for(Product2 p : prdtList)
             {
                 if(p.Id == oli.Product2Id)
                 {
                     oli.Description = p.Description;
                 }
             }   
          }
          else
          {
              oli.addError('Cant add product in opportunity as price is less than 10000');
          }
    }

}