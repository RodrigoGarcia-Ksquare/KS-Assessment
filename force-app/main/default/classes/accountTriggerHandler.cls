public with sharing class accountTriggerHandler {

    public static Integer countAccounts(List<Account> accList){
        return [SELECT COUNT() FROM Contact WHERE AccountID IN :accList];
    }

    public static void createAccounts(List<Account> acctList) {

        List<Contact> cntCollection = new List<Contact>();

        List<Contact> cntList = [SELECT Id, Name, Push_Date__c, Account.PushToVendor__c 
                                FROM Contact 
                                WHERE AccountId 
                                IN :acctList];

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

    public static void batchClass(List<Account> accList){
        batchClass obj = new batchClass(accList);
        Id batchId = Database.executeBatch(obj, 150);
    }

    public static void queueableClass(List<Account> accList){
        queueableClass obj = new queueableClass(accList);
        system.enqueueJob(obj);
    }

}