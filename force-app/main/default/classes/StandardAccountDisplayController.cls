public with sharing class StandardAccountDisplayController
{ 
    public String records {get; set;} 
    public StandardAccountDisplayController()
    { 
         records = [select Id,Name, Description from Account where id='0015j00000wzMNrAAM' limit 1].Description	;
    } 
}