public with sharing class accountRecords {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String acctId) {
        system.debug(acctId);
        String accId = string.escapeSingleQuotes(acctId);
        String query;
        
            query = 'SELECT Id, Name, Email, Phone, Title'
    			+' FROM Contact'
    			+' WHERE AccountId =\'' +accId+'\''
                +' ORDER BY Name';
        
        system.debug(Database.query( query ));
        return Database.query( query );
    }

    @AuraEnabled
    public static List<Contact> getContactDetail(String cntId){
        try {
            String contactId = string.escapeSingleQuotes(cntId);
            String query;

                query = 'SELECT Id, Name, Email, Phone'
                    +' FROM Contact'
                    +' WHERE AccountId =\'' +accId+'\''
                    +' AND Id =\'' +conId+'\'';

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}