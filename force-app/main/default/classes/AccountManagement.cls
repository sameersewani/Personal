@RestResource(urlmapping='/AccountManagement/')

global class AccountManagement
{
    @HTTPGet
    global static String ShowInfo()
    {
          ID i;
        
         RestRequest req= RestContext.request;
         RestResponse res= RestContext.response;

       
        i=req.headers.get('Id');
        account a = [SELECT Name,type from account where id = :i ];
        return a.Name;
       
    }
    
    

    
    
    
    
    
    @HTTPPost
    global static String CreateAccount()
    {
            
            RestRequest req= RestContext.request;
            RestResponse res= RestContext.response;
 
            String jsonbody= req.requestBody.toString();
            map<string,object> mmap= (map<string,object>)JSON.deserializeUntyped(jsonBody);
            system.debug(mmap);
            string Name = (string)mmap.get('Name');
            Integer noe = (integer)mmap.get('NumberOfEmployees');
        
            account a = new account(Name=Name,NumberOfEmployees=noe );
            insert a;
            return a.id;
        
    }
    
         @HTTPPut
        global static String UpdateAccount()
        {
             
            Id i;
            RestRequest req= RestContext.request;
            RestResponse res= RestContext.response;
            
            String jsonbody= req.requestBody.toString();
            map<string,object> mmap= (map<string,object>)JSON.deserializeUntyped(jsonBody);
            
            //system.debug(mmap);
            i=req.headers.get('Id');
            string Name = (string)mmap.get('Name');
            Integer noe = (integer)mmap.get('NumberOfEmployees');
            account a = new Account(Name=name,id=i,NumberOfEmployees=noe); 
            update a;
            return a.id;
            
        }
    
     @HTTPDelete
        global static String DeleteAccount()
        {
            Id i;
            RestRequest req= RestContext.request;
            RestResponse res= RestContext.response;
            
        
            i=req.headers.get('Id'); 
            Account a=[select name from Account  where id=:i];
            delete a;
            return a.id;
            
        }
    
    
    @HTTPpatch
    global static String CrtAccount()
        {
            String fname,fieldname,fieldvalue;
            
            RestRequest req= RestContext.request;
            RestResponse res= RestContext.response;
            
           
            
            String jsonbody= req.requestBody.toString();
            map<string,object> mmap= (map<string,object>)JSON.deserializeUntyped(jsonBody);
            //system.debug(mmap);
            //
            list<account> aLIst = new List<account>();
            
			list<object> mList = (list<object>)mmap.get('account') ;
            
            for(object a : mlist)
            {
                map<string,object> b = (map<string,object>)a;
                //system.debug(b);
                string Name = (string)b.get('Name');
                Integer noe = (integer)b.get('NumberOfEmployees');
                account ac = new account(Name=Name,NumberOfEmployees=noe );
                aLIst.add(ac);
      
            }  
            insert aLIst;
            return 'success';
            
        }
    
    
    
    
   
}