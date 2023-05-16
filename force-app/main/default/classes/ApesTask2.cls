@RESTResource(urlMapping='/ApexTask/')
global class ApesTask2
{
	@HTTPPost
    global static List<String> CreateData()
    {
                  
            RestRequest req= RestContext.request;
            RestResponse res= RestContext.response;
 
            String jsonbody= req.requestBody.toString();
            map<string,object> mmap= (map<string,object>)JSON.deserializeUntyped(jsonBody);
            system.debug(mmap); 
        
            List<String> ids= new List<String>();
        
        // Deal
            string Dname = (string)mmap.get('DealName__c');
            String des =(string)mmap.get('Description__c');
            Integer Damt =(Integer)mmap.get('Amount__c');
            String contact =(string)mmap.get('Contact__c');
            String DEId =(string)mmap.get('deal_external_system_id__c');
            string Ddate =(string)mmap.get('Deal_last_modified_date__c');
    
            List<String>str1 = Ddate.split('-');  
            date da = Date.newInstance(integer.valueof(str1[0]),integer.valueof(str1[1]),integer.valueof(str1[2]));
        
         if(Dname!=null)
         {
             
             list<Deals__c>Dlist=[select DealName__c,Amount__c,Contact__c,deal_external_system_id__c,Deal_last_modified_date__c from Deals__c where deal_external_system_id__c= :DEId];
             system.debug(Dlist); 
              
             if(Dlist.size()!=0)
             {
                 for(Deals__c oldDeals : Dlist)
                 {
                     if(oldDeals.deal_external_system_id__c==DEId)
                     {
                         if(oldDeals.Deal_last_modified_date__c< da)
                         {
                             oldDeals.DealName__c=Dname;
                             system.debug(oldDeals.DealName__c);
                         }
                     }
                     
                 }
             }
            else
                 {
                     Deals__c d= new Deals__c(DealName__c=Dname, Amount__c=Damt, Contact__c=contact, Description__c=des, deal_external_system_id__c=DEId,Deal_last_modified_date__c=da);
                     insert d;
                     ids.add(d.Id);
                 }
             
             update Dlist;
         }
           
        
        // Company
            String Cname =(string)mmap.get('CompanyName__c');
            String Cdesc=(string)mmap.get('Descriptionnn__c');
            string Cdate =(string)mmap.get('Company_last_modified_datetime__c');
            String CEId=(string)mmap.get('Company_external_system_id__c');
        
            List<String>str2 = Cdate.split('-');  
            date da2 = Date.newInstance(integer.valueof(str2[0]),integer.valueof(str2[1]),integer.valueof(str2[2]));
        
        if(Cname!=null)
        {              
            list<Company__c> Clist=[select CompanyName__c,Company_external_system_id__c,Company_last_modified_datetime__c from Company__c where Company_external_system_id__c=:CEId ];
            system.debug(Clist);
            
            
             if(Clist.size()!=0)
             {
                 for(Company__c oldCompany : Clist)
                 {
                     if(oldCompany.Company_external_system_id__c==CEId)
                     {
                         if(oldCompany.Company_last_modified_datetime__c< da2)
                         {
                             oldCompany.CompanyName__c=Cname;
                             system.debug(oldCompany.CompanyName__c);
                         }
                     }
                     
                 }
             }
            else
                 {
                      Company__c comp= new Company__c(CompanyName__c=Cname, Descriptionnn__c=Cdesc, Company_external_system_id__c=CEId, Company_last_modified_datetime__c=da2);
                      insert comp;
                     ids.add(comp.Id);
                 }
             
             update Clist;
            
             
        }
                       
          return ids;
        
        
    }

}