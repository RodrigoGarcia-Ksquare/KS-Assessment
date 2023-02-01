public with sharing class accountRecords {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String acctId, Integer limitSize, Integer offSetCount, String cntId) {
        system.debug(acctId);
        system.debug(cntId);
        String accId = string.escapeSingleQuotes(acctId);
        String contId = string.escapeSingleQuotes(cntId);
        String query;
        
        if (contId != '' || contId == null) {
            query = 'SELECT Id, Name, Email, Phone'
            +' FROM Contact'
            +' WHERE AccountId =\'' +accId+'\''
            +' AND Id =\'' +contId+'\'';
        }
        else {
            query = 'SELECT Id, Name, Email, Phone'
            +' FROM Contact'
            +' WHERE AccountId =\'' +accId+'\''
            +' ORDER BY Name'
            +' LIMIT '+limitSize
            +' OFFSET '+offSetCount;
        }

        system.debug(Database.query( query ));
        return Database.query( query );
    }


    @AuraEnabled(cacheable=true)
    public static String getAccountName(String acctId){
        try {
            Account accountInfo =  [SELECT Id, Name FROM Account WHERE Id =:acctId];
            String accountName = accountInfo.Name;
            return accountName;
        } catch (Exception e) {
            return null;
        }
    }

    @AuraEnabled
    public static List<Contact> searchContacts(String acctId, String cntName){
        try {
            String conName = cntName + '%';
            String accountId = string.escapeSingleQuotes(acctId);
            conName = string.escapeSingleQuotes(conName);
            String query;

            query = 'SELECT Id, Name'
                    +' FROM Contact'
                    +' WHERE Name LIKE :conName AND AccountId =\'' +accountId+'\''
                    +' ORDER BY Name LIMIT 5';

        system.debug(Database.query(query));
        return Database.query(query);

        } catch (Exception e) {
            return null;
        }
    }

}