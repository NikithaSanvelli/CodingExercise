trigger UserTrigger on User (before insert, Before update, After insert, After update){
    switch on Trigger.OperationType  {
        when BEFORE_INSERT {
            System.debug('Befor Insert' );
        }
        when AFTER_INSERT {
            System.debug('After Insert' );
        }
        when BEFORE_UPDATE {
            System.debug('Before Update' );
        }
        when AFTER_UPDATE {
            System.debug('After Update' );
            UserTriggerHandler.afterUpdate(trigger.oldMap, trigger.newMap);
        }
    }
}