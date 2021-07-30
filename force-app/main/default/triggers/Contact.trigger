trigger Contact on Contact (before insert, after insert, before update, after update, before delete) {

    if(trigger.isBefore){
        System.debug('Before >>> ');
     
        System.debug(trigger.new[0]);

    }
    else if(trigger.isAfter){
        System.debug('After >>> ');
    }
    
    ContactTriggerHandler handler = new ContactTriggerHandler();
    
    Switch on trigger.operationType{
        when Before_Insert{
            handler.onBeforeInsert(trigger.new);
        }
        when After_Insert{
            handler.onAfterInsert(trigger.new);
        }
        when Before_Update{
            handler.onBeforeUpdate(trigger.new, trigger.oldMap);
        }
        when After_Update{
            handler.onAfterUpdate(trigger.new, trigger.oldMap);
        }
        when BEFORE_DELETE{
            handler.onBeforeDelete(trigger.old, trigger.oldMap);
        }
    }
}