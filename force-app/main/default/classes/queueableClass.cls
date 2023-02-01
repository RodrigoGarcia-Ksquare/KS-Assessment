public with sharing class queueableClass implements Queueable {

    List<Account> accountsList;

    public queueableClass(List<Account> accList){
        accountsList = accList;
    }

    public void execute(QueueableContext context){
        List<Contact> cntCollection = new List<Contact>();

        List<Contact> cntList = [SELECT Id, Name, Push_Date__c, Account.PushToVendor__c 
                                FROM Contact 
                                WHERE AccountId 
                                IN :accountsList];

        for (Contact c : cntList) {
            if(c.Account.PushToVendor__c == 'Yes'){
                c.Push_Date__c = Datetime.now();
                cntCollection.add(c);
            }
            else if(c.Account.PushToVendor__c == 'No'){
                c.Push_Date__c = null;
                cntCollection.add(c);
            } 
        }
        update cntCollection;
    }

}