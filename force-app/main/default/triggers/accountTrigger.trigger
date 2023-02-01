trigger accountTrigger on Account (after update) {

    if (accountTriggerHandler.countAccounts(Trigger.New ) <= 200) {
        accountTriggerHandler.createAccounts(Trigger.New);

    }

    if (accountTriggerHandler.countAccounts(Trigger.New) > 200 && accountTriggerHandler.countAccounts(Trigger.New) <= 1000) {
        accountTriggerHandler.queueableClass(Trigger.New);
    }
    
    if(accountTriggerHandler.countAccounts(Trigger.New) > 1000){
        accountTriggerHandler.batchClass(Trigger.New);
    }

}