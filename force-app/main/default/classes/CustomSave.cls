public with sharing class CustomSave
 {
    @AuraEnabled
     public static List<List<Sobject>> myApexMethod(String jsonString)
      {
          List<object> parsedData = (List<object>)JSON.deserializeUntyped(jsonString);     
          system.debug(parsedData);
          
          List<sobject> demo= new List<sobject>();
          List<Account> a=[select id,name,external_id__c from account where external_id__c !=null order by external_id__c desc];
          Integer temp=0;
          for(Account acc :a)
          {
              if(integer.valueof(acc.external_id__c)>temp)
                  {
                      temp=integer.valueof(acc.external_id__c);
                  }
          }
          integer falloff=temp+1;
          
          for(integer i=0; i<parsedData.size();i++)
          {
              Object o=parsedData[i];
             Map<string,object> mmap=(Map<string,object>)o;
             //system.debug(mmap.get('name'));
              
              Account acc = new Account();
              acc.Name=(String)mmap.get('name');
              acc.AccountEmail__c=(String)mmap.get('email');
              acc.external_id__c=falloff+i+'';
              
              Account accrefrence = new Account();
              accrefrence.external_id__c=falloff+i+'';
              
              demo.add(acc);
              
                for(object con: (List<object>)mmap.get('con'))
                {
                    Map<string,object> mmap2=(Map<string,object>)con;
                       Contact c = new Contact();
                      c.LastName=(String)mmap2.get('name');
                      c.EmailC__c=(String)mmap2.get('email');
                      c.Account=accrefrence;
                      demo.add(c);
                }
              for(object opp: (List<object>)mmap.get('opp'))
                {
                    Map<string,object> mmap3=(Map<string,object>)opp;
                       Opportunity op = new Opportunity();
                      op.Name=(String)mmap3.get('name');
                      op.StageName=(String)mmap3.get('StageName');
                     String d=(String)mmap3.get('Date');
                      op.CloseDate=Date.valueOf(d);
                      op.Account=accrefrence;
                      demo.add(op);
                }
              for(object doo: (List<object>)mmap.get('doc'))
                {
                       ContentDocumentLink  cdl= new ContentDocumentLink();
                       cdl.ContentDocumentId=(string)doo;
                    	cdl.putSobject('LinkedEntity', accrefrence);
                       demo.add(cdl);
                       
                }       
         }
          Database.SaveResult[] results = Database.insert(demo, false);
          Set<String> eId=new Set<String>();
          List<List<Sobject>> failedRecords = new List<List<Sobject>>();
          List<Account> failedAccount = new List<Account>();
          List<Opportunity> failedOpportunity = new List<Opportunity>();
          List<Contact> failedContact = new List<Contact>();
          List<Account> insertAccount = new List<Account>();
          List<Opportunity> insertOpportunity = new List<Opportunity>();
          List<Contact> insertContact = new List<Contact>();
           

          for (integer i=0; i<results.size();i++)
          {
              Database.SaveResult result=results[i];
              if (result.isSuccess()) 
              {
                  System.debug('inserted Record	 Id is: ' + result.getId());
                  String sObjectType = demo[i].getSObjectType().getdescribe().getname();
                  if(sObjectType=='Contact' )
                  {
                      Contact temp1=(contact)demo[i];
                      eId.add(temp1.Account.external_id__c);
                      insertContact.add(temp1);
                  }	
                  else if(sObjectType=='Opportunity' )
                  {
                      Opportunity temp2=(Opportunity)demo[i];
                      eId.add(temp2.Account.external_id__c);
                      insertOpportunity.add(temp2);
                  }
                  else if(sObjectType=='Account' )
                  {
                      Account temp3=(Account)demo[i];
                      insertAccount.add(temp3);
                  }
              }
              else
              {
                  
				String sObjectType = demo[i].getSObjectType().getdescribe().getname();
                  if(sObjectType=='Contact' )
                  {
                      Contact temp1=(contact)demo[i];
                      eId.add(temp1.Account.external_id__c);
                      failedContact.add(temp1);
                  }	
                  else if(sObjectType=='Opportunity' )
                  {
                      Opportunity temp2=(Opportunity)demo[i];
                      eId.add(temp2.Account.external_id__c);
                      failedOpportunity.add(temp2);
                  }
                  else if(sObjectType=='Account' )
                  {
                      Account temp3=(Account)demo[i];
                      failedAccount.add(temp3);
                  }
              }    
              system.debug(eId);
          }
          List<Account> acclist=[select id from account where external_id__c in:eId];
          List<Contact> clist=[select id from contact where AccountId in :acclist];
          if(clist.size()>0)
          {
              delete clist;
          }
          List<Opportunity> olist=[select id from Opportunity where AccountId in :acclist];
          if(olist.size()>0)
          {
              delete olist;
          }
          
          if(acclist.size()>0)
          {
              delete acclist;
          }
          failedRecords.add(failedAccount);
          failedRecords.add(failedContact);
          failedRecords.add(failedOpportunity);
          failedRecords.add(insertAccount);
          failedRecords.add(insertContact);
          failedRecords.add(insertOpportunity);
          system.debug(failedRecords);
          return failedRecords;
     }//Method
}