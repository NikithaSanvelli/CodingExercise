trigger UserTrigger on User (after update){
    switch on Trigger.OperationType  {
        when AFTER_UPDATE {
            System.debug('Calling After Update Trigger');
            UserTriggerHandler.afterUpdate(trigger.oldMap, trigger.newMap);
        }
    }
}
