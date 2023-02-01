@isTest
public class accountTriggerHandlerTest {

    static testMethod void syncrhnousTest(){
        
        Integer AccountToPush = 6;
        Integer AccountNoToPush = 7;
        Integer cntNumber = 2;

        Test.startTest();

        List<Account> acctList = new List<Account>();
        List<Contact> cntList = new List<Contact>();

        for (Integer i = 1; i <= AccountToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i,PushToVendor__c = 'Yes');
            acctList.add(account);
        }
        
        for (Integer i = 1; i <= AccountNoToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i, PushToVendor__c = 'No');
            acctList.add(account);
        }

        insert acctList;

        for(Account account : acctList){
            for (Integer i = 1; i <= cntNumber; i++){
                Contact contact = new Contact(LastName = 'Test Contact ' + i, AccountId = account.Id);
                cntList.add(contact);
            }
        }

        insert cntList;

        Database.SaveResult[] result = Database.update(acctList, true);

        Test.stopTest();
        
        List<Contact> contactNull = [SELECT Id, Push_Date__c  FROM Contact WHERE Push_Date__c != null];
        system.assertEquals(12, contactNull.size());

    }
    
    static testMethod void queueableTest(){
        
        Integer AccountToPush = 70;
        Integer AccountNoToPush = 30;
        Integer cntNumber = 3;

        Test.startTest();

        List<Account> acctList = new List<Account>();
        List<Contact> cntList = new List<Contact>();

        for (Integer i = 1; i <= AccountToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i,PushToVendor__c = 'Yes');
            acctList.add(account);
        }
        
        for (Integer i = 1; i <= AccountNoToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i, PushToVendor__c = 'No');
            acctList.add(account);
        }

        insert acctList;

        for(Account account : acctList){
            for (Integer i = 1; i <= cntNumber; i++){
                Contact contact = new Contact(LastName = 'Test Contact ' + i, AccountId = account.Id);
                cntList.add(contact);
            }
        }

        insert cntList;

        Database.SaveResult[] result = Database.update(acctList, true);

        Test.stopTest();
        
        List<Contact> contactNull = [SELECT Id, Push_Date__c  FROM Contact WHERE Push_Date__c != null];
        system.assertEquals(210, contactNull.size());

    }

    static testMethod void batchTest(){
        
        Integer AccountToPush = 6;
        Integer AccountNoToPush = 7;
        Integer cntNumber = 9;

        Test.startTest();

        List<Account> acctList = new List<Account>();
        List<Contact> cntList = new List<Contact>();

        for (Integer i = 1; i <= AccountToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i,PushToVendor__c = 'Yes');
            acctList.add(account);
        }
        
        for (Integer i = 1; i <= AccountNoToPush; i++){
            Account account = new Account(Name = 'Test Account ' + i, PushToVendor__c = 'No');
            acctList.add(account);
        }

        insert acctList;

        for(Account account : acctList){
            for (Integer i = 1; i <= cntNumber; i++){
                Contact contact = new Contact(LastName = 'Test Contact ' + i, AccountId = account.Id);
                cntList.add(contact);
            }
        }

        insert cntList;

        Database.SaveResult[] result = Database.update(acctList, true);

        Test.stopTest();
        
        List<Contact> contactNull = [SELECT Id, Push_Date__c  FROM Contact WHERE Push_Date__c != null];
        system.assertEquals(54, contactNull.size());

    }

}