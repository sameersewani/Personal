public class test
{
    public static void displayRecords(String objectName, String field1, String field2,String nameLike)
    {
        
       String q='select name' +field1+ ', ' +field2+ ' from ' +objectName+ ' where name like \'' +nameLike+'%\'' ;
        List <sobject> slist=Database.query(q);   
        for(sobject s:slist)
        {
            system.debug(s);
        }
        
    }
    
    public static void display(String objectName, List<String> fields)
    {
        String ans;
        for(integer i=0;i<fields.size();i++)
        {
            if(i==0)
            {
                 ans=fields[0]+',';
            }
            else if(i==fields.size()-1)
            {
                ans+=fields[i];
            }
            else
            {
                ans+=fields[i]+',';
            }
        }//for
             String q='select ' +ans+ ' from ' +objectName;
                 //+ ' where '+fields[0]+' like \'' +nameLike+'%\'' ;
             System.debug(q);
			 List <sobject> slist=Database.query(q);   
    		   for(sobject s : slist)
      			{
                   system.debug(s);
                } 
    }//main
    

    /////////////////////////////////////////////////////////////////////
    
    public static void  insertLeadRecords(List<Lead> llist)
    {
        Database.SaveResult[] saveList= Database.insert(llist,false);
        for(Database.saveResult s : saveList)
        {
            if(s.isSuccess())
            {
                System.debug('i was successful='+s.getID());
            }
            else
            {
                System.debug('i was Unsuccessful'); 
                       
            }
        }
        system.debug(llist);    
    }
    
    public static void createLead()
    {
        List<Lead> llist = new List<Lead>();
       for(integer i=0; i<5; i++)
        {
            Lead l= new Lead(Lastname='abcd'+i, Company='ab', Status='Open-Not Contacted');
            llist.add(l);
        } 
     	llist.add(new lead(Company = 'az'));
        insertLeadRecords(llist);
    }
    
      /////////////////////////////////////////////////////////////////////
    
    public static void searchLeadsContact(String text)
    {
        String q= 'Find \''+text+'*\' in name fields returning Account(name), Contact(name)';
        system.debug(q);
        List<List <sobject>> slist=search.query(q);   
        system.debug(slist);
    }
    
    
     ///////////////////////////////////////////////////////////////////// 
    
    public static void  mergeLeads(List<Lead> llist)
    {
        Lead a=llist[0];
        Lead b=llist[1];
        Lead c=llist[2];
        Lead d=llist[3];
        Lead e=llist[4];
        Lead f=llist[5];
         
        List<Lead> mlist= new List<Lead>();
        mlist.add(llist[1]);//2
        mlist.add(llist[2]);//3
        
         List<Lead> mlist1= new List<Lead>();
        mlist1.add(llist[4]);//5
        mlist1.add(llist[5]);//6
        
        Database.MergeResult[] r1= Database.merge(a,mlist,false);   // 2 and 3 with 1
        Database.MergeResult[] r2=Database.merge(d,mlist1,false);// 4 and 5 with 6
        
        for(Database.MergeResult res : r1)
           {
                if(res.isSuccess())
                {
                    system.debug('Master records id'+ res.getId());       
                    // Get the IDs of the merged records and display them
                    List<Id> mergedIds = res.getMergedRecordIds();
                    System.debug('IDs of merged records: ' + mergedIds);     
                }
                else
                {
                    for(Database.Error err : res.getErrors())
                   {
                    // Write each error to the debug output
                    System.debug(err.getMessage());
                   }
                }
                
          }
         for(Database.MergeResult res : r2)
           {
                if(res.isSuccess())
                {
                    system.debug('Master records id'+ res.getId());       
                    // Get the IDs of the merged records and display them
                    List<Id> mergedIds = res.getMergedRecordIds();
                    System.debug('IDs of merged records: ' + mergedIds);     
                }
                else
                {
                    for(Database.Error err : res.getErrors())
                   {
                    // Write each error to the debug output
                    System.debug(err.getMessage());
                   }
                }
                
          } 
        
    }
    
    public static void createLead1()
    {
        List<Lead> l =[select id from lead Limit 6];

        mergeLeads(l);
    }
      /////////////////////////////////////////////////////////////////////
    public static void deleteStudentAndAccount()
    {
        	    List<Student__c> slist=[select id from Student__c where isdeleted=true All Rows];
        		Database.emptyRecycleBin(slist);
        
               List<Account> alist=[select id from Account where isdeleted=true All Rows];
        		Database.emptyRecycleBin(alist);   		
    }
      /////////////////////////////////////////////////////////////////////
  
    
    
    public static void convertLeads()
    {
        
         Lead l =[SELECT name,id,Status,owner.name,owner.id FROM Lead where status='Working - Contacted'];
            Database.leadConvert lc = new Database.leadConvert();
            lc.setLeadId (l.id);
            System.debug('ID of record inserted is:' +l.id);
            lc.convertedStatus='Closed - Converted';
            lc.ownerId = '0055j000003krWx'; // any user id
            Database.leadConvertResult lcr = Database.convertLead(lc);
    }
}