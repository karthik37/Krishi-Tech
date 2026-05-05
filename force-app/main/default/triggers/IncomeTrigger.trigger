trigger IncomeTrigger on Income__c (after insert, after update, after delete, after undelete) {
    Set<Id> cropCycleIds = new Set<Id>();
    
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Income__c inc : Trigger.new) {
            if (inc.Crop_Cycle__c != null) {
                cropCycleIds.add(inc.Crop_Cycle__c);
            }
            if (Trigger.isUpdate) {
                Income__c oldInc = Trigger.oldMap.get(inc.Id);
                if (oldInc.Crop_Cycle__c != null && oldInc.Crop_Cycle__c != inc.Crop_Cycle__c) {
                    cropCycleIds.add(oldInc.Crop_Cycle__c);
                }
            }
        }
    }
    
    if (Trigger.isDelete) {
        for (Income__c inc : Trigger.old) {
            if (inc.Crop_Cycle__c != null) {
                cropCycleIds.add(inc.Crop_Cycle__c);
            }
        }
    }
    
    if (!cropCycleIds.isEmpty()) {
        IncomeTriggerHandler.updateCropCycleTotals(cropCycleIds);
    }
}