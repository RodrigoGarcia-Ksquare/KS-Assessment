public with sharing class batchClass implements Database.Batchable<SObject>{

    List<Account> accountsList;

    public batchClass(List<Account> accList){
        accountsList = accList;
    }

    public database.queryLocator start(Database.BatchableContext BC)
    {
        //this is where you get records for processing, or access to a list of records that is           //already been passed and available to the Batch class
        String query = 'SELECT Id, Name, Push_Date__c, Account.PushToVendor__c'
                        +' FROM Contact' 
                        +' WHERE AccountId' 
                        +' IN :accountsList';
       
        return Database.getQueryLocator(query);
    }
      
    public void execute(Database.BatchableContext BC, List<Contact> cntList)
     {
        //this is where you should be processing the records, making callouts to external systems
        List<Contact> cntCollection = new List<Contact>();
        
        for (Contact c : cntList) {
            if(c.Account.PushToVendor__c == 'Yes'){
                c.Push_Date__c = Datetime.now();
            	cntCollection.add(c);
            }
            else if(c.Account.PushToVendor__c == 'No'){
                c.Push_Date__c = null;
            	cntCollection.add(c);
            } 
        update cntCollection;
        }
     
    }
      
    public void finish(Database.BatchableContext BC)
     {
           
        //finish method is where you do your DML and commit your processed information to Salesforce, this is for creating log records for your integration, and updating processed records to the database and chaining another batch class or even schedule one.
    }

}