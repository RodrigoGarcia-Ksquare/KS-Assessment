trigger accountTrigger on Account (after update) {

    if (accountTriggerHandler.countAccounts(Trigger.New) <= 100) {
        accountTriggerHandler.createAccounts(Trigger.New);
    }

    if (accountTriggerHandler.countAccounts(Trigger.New) > 100 && accountTriggerHandler.countAccounts(Trigger.New) <= 1000) {
        accountTriggerHandler.queueableClass(Trigger.New);
    }
    
    if(accountTriggerHandler.countAccounts(Trigger.New) > 1000|| (Test.isRunningTest() && accountTriggerHandler.countAccounts(Trigger.New) > 100 && accountTriggerHandler.countAccounts(Trigger.New) < 200)){
        accountTriggerHandler.batchClass(Trigger.New);
    }

}