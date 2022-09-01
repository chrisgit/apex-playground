trigger AddressChangeEventTrigger on Address_Change_Event__e (after insert) {
    AddressChangeEventTriggerHandler.afterInsert(trigger.new);
}
