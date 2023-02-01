@isTest
public class accountRecordsTest {
    
    static testMethod void searchContactsTest() {
        String cntName = 'Con';
        String cntFullName = 'Contact 1';
        Integer cntNumber = 5;

        Integer NumContacts = 5;

        //Accounts creation}

        List<Account> acctList = new List<Account>();
        List<Contact> conts = new List<Contact>();

        Account accountTest = new Account(Name = 'TestAccount 1');
        acctList.add(accountTest);
        insert acctList;

        for(Integer i = 0; i < 1; i++){

            Account acc = acctList[i];

            for (Integer j = 0; j < NumContacts; j++) {
                Contact cnt = new Contact(LastName = 'Contact '+j, AccountId = acc.Id);
                conts.add(cnt);
            }
            
        }
        insert conts;

        //Test Area

        Contact[] multiConts = accountRecords.searchContacts(acctList[0].Id, cntName);
        Contact[] singleCont = accountRecords.searchContacts(acctList[0].Id, cntFullName);

        system.assertEquals(1, singleCont.size());
        system.assertEquals(5, multiConts.size());

        Contact[] error = accountRecords.searchContacts('noid', 'cont');
        system.assertEquals(null, error);

    }

    static testMethod void getAccountNameTest(){

        //Account Creation
        Account accountTest = new Account(Name = 'TestAccount 1');
        insert accountTest;

        String accountName = accountRecords.getAccountName(accountTest.Id);
        String error = accountRecords.getAccountName('');

        system.assertEquals('TestAccount 1', accountName);
        system.assertEquals(null, error);

    }

    static testMethod void getContactsTest(){

        //Data needed
        Integer NumContacts = 10;
        Integer limitSize = 5;
        Integer offSetCount = 0;

        //Records Creation
        //Account Creation
        Account accountTest = new Account(Name = 'TestAccount 1');
        insert accountTest;

        List<Contact> conts = new List<Contact>();

        for (Integer j = 0; j < NumContacts; j++) {
            Contact cnt = new Contact(LastName = 'Contact '+j, AccountId = accountTest.Id);
            conts.add(cnt);
        } insert conts;
            
        //Test area

        Contact[] multiConts = accountRecords.getContacts(accountTest.Id, limitSize, offSetCount, '');
        Contact[] singleConts = accountRecords.getContacts(accountTest.Id, limitSize, offSetCount, conts[2].Id);

        system.assertEquals(limitSize, multiConts.size());
        system.assertEquals(1, singleConts.size());

    }

}