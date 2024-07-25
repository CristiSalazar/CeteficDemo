trigger profesionalTrigger on Pacient__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            profesionalTriggerHandler.beforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            profesionalTriggerHandler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }
    }
}