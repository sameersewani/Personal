@RestResource(urlMapping='/createOpportunity/')
global class FieldSet1
{
	@HTTPPost
    Global static string createOpportunity()
    {
        RestRequest req=RestContext.request;
         String jSonBody=req.requestBody.tostring();
        //opportunity
        List<Schema.FieldSetMember>fs1 = Schema.SObjectType.opportunity.fieldSets.getMap().get('opportunityfield').getfields();
		String query = 'SELECT ';
        for(Schema.FieldSetMember f :fs1) 
        {
            query += f.getFieldPath() + ', ';
        }
        query+='AccountId from opportunity where id='+'\''+jsonbody+'\'';
        opportunity opp=database.query(query);
        
        //account
        List<Schema.FieldSetMember>fs2 = Schema.SObjectType.account.fieldSets.getMap().get('AccountFieldset').getfields();
		String queryacc = 'SELECT ';
        for(Schema.FieldSetMember f :fs2) 
        {
            queryacc += f.getFieldPath() + ', ';
        }
        queryacc+='id from account where id='+'\''+opp.AccountId+'\'';
        system.debug(queryacc);
        account acc=database.query(queryacc);
        system.debug(acc);
       
        //contact
         List<Schema.FieldSetMember>fs3 = Schema.SObjectType.contact.fieldSets.getMap().get('contactfieldset').getfields();
		String querycc = 'SELECT ';
        for(Schema.FieldSetMember f :fs3) {
            querycc += f.getFieldPath() + ', ';
        }
        querycc+='id from contact where accountid='+'\''+opp.AccountId+'\'';
        system.debug(querycc);
        List<contact> cc=database.query(querycc);
        //opportunity owner
		List<Schema.FieldSetMember>fs4 = Schema.SObjectType.user.fieldSets.getMap().get('userfieldset').getfields();
		String queryu = 'SELECT ';
        for(Schema.FieldSetMember f :fs4) 
        {
            queryu += f.getFieldPath() + ', ';
        }
        queryu+='id from user where id='+'\''+opp.ownerid+'\'';
        system.debug(queryu);
       user u=database.query(queryu);
        system.debug(u);
        
        
        

        /*opportunity op=[select id,name,stagename,
                        closedate,isclosed,
                        owner.Profile.Name,
                        owner.name,owner.email,
                        account.name,account.annualrevenue,
                        account.description,accountid from opportunity where id=:jsonbody];
        List<contact> conclist=[select firstname,lastname,phone,email from contact where accountid=:op.AccountId];
        system.debug(conclist);*/
        string s='{ "Opportunity":{ "Name": "'+opp.Name+'", StageName:"'+opp.StageName+ '", CloseDate:"'+opp.CloseDate+'", IsClosed:"'+opp.IsClosed+'", Opportunity_Owner:{ Name:"'+u.name+'", Email:"'+u.email+'", ProfileName:"'+u.ProfileId+'" }, Account:{ name:"'+Acc.name+'", amount:"'+Acc.annualrevenue+'", description:"'+acc.description+'" }, Contacts:{'+string.valueOf(cc)+' } }}' ;
        system.debug(s);
        return s;
    }
}