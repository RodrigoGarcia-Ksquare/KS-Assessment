public with sharing class accountRecords {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String acctId, Integer limitSize, Integer offSetCount) {
        system.debug(acctId);
        String accId = string.escapeSingleQuotes(acctId);
        String query;
        
            query = 'SELECT Id, Name, Email, Phone'
    			+' FROM Contact'
    			+' WHERE AccountId =\'' +accId+'\''
                +' ORDER BY Name'
                +' LIMIT '+limitSize
                +' OFFSET '+offSetCount;
        
        system.debug(Database.query( query ));
        return Database.query( query );
    }

}