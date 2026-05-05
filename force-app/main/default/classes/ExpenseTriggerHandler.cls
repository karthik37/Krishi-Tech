public with sharing class ExpenseTriggerHandler {
    public static void updateCropCycleTotals(Set<Id> cropCycleIds) {
        // Query all expenses for these crop cycles
        Map<Id, Decimal> expenseTotals = new Map<Id, Decimal>();
        
        for (AggregateResult ar : [
            SELECT Crop_Cycle__c, SUM(Amount__c) total
            FROM Expense__c
            WHERE Crop_Cycle__c IN :cropCycleIds
            GROUP BY Crop_Cycle__c
        ]) {
            Id cycleId = (Id)ar.get('Crop_Cycle__c');
            Decimal total = (Decimal)ar.get('total');
            expenseTotals.put(cycleId, total);
        }
        
        // Query crop cycles and update totals
        List<Crop_Cycle__c> cyclesToUpdate = [
            SELECT Id, Total_Input_Cost__c
            FROM Crop_Cycle__c
            WHERE Id IN :cropCycleIds
        ];
        
        for (Crop_Cycle__c cycle : cyclesToUpdate) {
            cycle.Total_Input_Cost__c = expenseTotals.containsKey(cycle.Id) 
                ? expenseTotals.get(cycle.Id) 
                : 0;
        }
        
        if (!cyclesToUpdate.isEmpty()) {
            update cyclesToUpdate;
        }
    }
}
