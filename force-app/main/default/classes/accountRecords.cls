public with sharing class accountRecords {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String acctId) {
        system.debug(acctId);
        String accId = string.escapeSingleQuotes(acctId);
        String query;
        
        if (accId != '') {
            query = 'SELECT Id, Name, Email, Phone, Title'
    			+' FROM Contact'
    			+' WHERE AccountId =\'' +accId+'\'';
        }
        system.debug(Database.query( query ));
        // else {
        //     query = 'SELECT Id, Name, Email, Phone, Title'
    	// 		+' FROM Contact'
    	// 		+' WHERE AccountId =\'' +accId+'\''
        //         +' ORDER BY Name';
        // }
        return Database.query( query );
    }
}