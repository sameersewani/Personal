public class TETHandler
{
    public static void main(list<opportunityLineItem> oliList)
    {
            
        set<id> oppIdSet = new set<id>();// (Opportunity ID) related to oli
        
     map<opportunity,list<opportunityLineItem>> oppOLiMap = new map<opportunity,list<opportunityLineItem>>();// map of opportunity and list of oli
     map<product2,list<double>> prodQuantityMap = new map<product2,list<double>>();
     map<opportunity,id> oppAccMap = new map<opportunity,id>();
     set<id> prodId = new set<id>();	//product id related to opportunity product
        
        //opp id from oli list
        for(opportunitylineitem oli:oliList) 
        {
            oppIdSet.add(oli.OpportunityId);
        }
        
        //query all OLI related to inserted oli opportunity id
        list<opportunityLineItem> oliQueryList = [select id,name,quantity,Product2Id,opportunityid from opportunityLineItem 
                                                  where opportunityid=:oppIdSet];
        
        // map of opportunity & list of OLI
        list<opportunity> oppList = [select id,name,stageName,CloseDate,AccountId from opportunity where id =: oppIdSet];
        
        for(opportunityLineItem oli:oliQueryList)
        {
            prodId.add(oli.Product2Id);
            for(opportunity opp:oppList)
            {
                
                if(oli.OpportunityId == opp.id)
                {
                    oppAccMap.put(opp,opp.accountid);	//will use later for creating contracts(for order) 
                    
                    if(oppOLiMap.containsKey(opp)) 
                    {
                		oppOLiMap.get(opp).add(oli);                
                    }
                    else
                    {
                        
                		oppOLiMap.put(opp,new list<opportunityLineItem> {oli});
            		}  
                }
            }
        }
        system.debug('oppOLiMap: '+oppOLiMap);
        system.debug('oppAccMap: '+oppAccMap);
        //--------------------------------------
        
        //map of id & its product
        list<product2> productList = [select id,name from product2 where id =:prodId ];
        map<id,product2> prodIdObj = new map<id,product2>();
        
        for(product2 pr2:productList)
        {
            prodIdObj.put(pr2.id,pr2);
        }
        
        // map of opp-product & its quantity
        for(opportunity oppKey: oppOLiMap.keySet()) 
        {
            for(opportunityLineItem oliKey:oppOLiMap.get(oppKey))
            {
                
                if(prodQuantityMap.containsKey(prodIdObj.get(oliKey.Product2Id))) {
                    
                    prodQuantityMap.get(prodIdObj.get(oliKey.Product2Id)).add(oliKey.Quantity);
                    
                    double sum = 0;
                    for(double d:prodQuantityMap.get(prodIdObj.get(oliKey.Product2Id))) 
                    {
                        sum = sum + d;
                    }
                    prodQuantityMap.put(prodIdObj.get(oliKey.Product2Id),new List<double> {sum});
                }
                else
                	prodQuantityMap.put(prodIdObj.get(oliKey.Product2Id),new list<double> {oliKey.Quantity});
            }
        }
        system.debug('prodQuantityMap: '+prodQuantityMap);
        
        list<orderItem> orderProduct = [select id,product2.name,Product2Id,unitPrice,quantity from orderItem];     
        
        contract contractRec = new contract();
        order ord = new order();
        list<orderItem> oiList = new list<orderItem>();
        
        for(opportunity opp : oppOLiMap.keySet())
        {
            contractRec.AccountId = opp.AccountId;
            contractRec.Status='Draft';
        	contractRec.StartDate=date.today();
        	contractRec.ContractTerm=5;
            insert contractRec;
            
        	ord.accountid = contractRec.AccountId;
        	ord.Status = 'Draft';
        	ord.ContractId = contractrec.Id;
        	ord.EffectiveDate = date.today();
            insert ord;
                
            for(opportunityLineItem oli : oppOLiMap.get(opp))
            {
                for(product2 pr:productList) 
                {
                    if(pr.id == oli.Product2Id) 
                    {
                        orderitem oi = new orderitem();
                        oi.Product2Id=pr.id;
                        oi.Quantity = prodQuantityMap.get(pr)[0];
                        oi.OrderId = ord.Id;
                        oiList.add(oi);
                    }
                }
            }
        }
        //insert oiList;
        //update ord;
    }
}