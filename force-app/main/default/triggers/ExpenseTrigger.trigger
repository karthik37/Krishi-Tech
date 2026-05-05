trigger ExpenseTrigger on Expense__c (after insert, after update, after delete, after undelete) {
    Set<Id> cropCycleIds = new Set<Id>();
    
    // Collect Crop Cycle IDs from inserted/updated expenses
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Expense__c exp : Trigger.new) {
            if (exp.Crop_Cycle__c != null) {
                cropCycleIds.add(exp.Crop_Cycle__c);
            }
            // If the Expense was reparented, pick up the old Crop Cycle ID
            if (Trigger.isUpdate) {
                Expense__c oldExp = Trigger.oldMap.get(exp.Id);
                if (oldExp.Crop_Cycle__c != null && oldExp.Crop_Cycle__c != exp.Crop_Cycle__c) {
                    cropCycleIds.add(oldExp.Crop_Cycle__c);
                }
            }
        }
    }
    
    // Collect Crop Cycle IDs from deleted expenses
    if (Trigger.isDelete) {
        for (Expense__c exp : Trigger.old) {
            if (exp.Crop_Cycle__c != null) {
                cropCycleIds.add(exp.Crop_Cycle__c);
            }
        }
    }
    
    // Recalculate totals for affected Crop Cycles
    if (!cropCycleIds.isEmpty()) {
        ExpenseTriggerHandler.updateCropCycleTotals(cropCycleIds);
    }
}