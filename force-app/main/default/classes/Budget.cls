public class Budget 
{
    @AuraEnabled
    public static List<Budget__c> getBudget()
    {
        List<Budget__c> headers =[select Name,Status__c,TotalBLI__c from Budget__c];     
        return headers;
    }
    
    @AuraEnabled
    public static List<BudgetLineItem__c> getBudgetLineItem(Id i)
    {
        return[select Amount1__c,Amount2__c,Amount3__c,Amount4__c,Amount5__c from BudgetLineItem__c where Budget__c=:i];     
    }
    
    @AuraEnabled
    public static void total(integer amt, Id i)
    {
        //Budget__c getParentObj = [SELECT Id, TotalBLI__c FROM Budget__c WHERE Id =];       
        BudgetLineItem__c b=[select Budget__r.Id,Budget__r.TotalBLI__c from BudgetLineItem__c where id=:i];
        Budget__c getParentObj =[select Name,Status__c,TotalBLI__c from Budget__c where Id=:b.Budget__r.Id];     
        getParentObj.TotalBLI__c=amt;  
        update getParentObj;
    }
    
}