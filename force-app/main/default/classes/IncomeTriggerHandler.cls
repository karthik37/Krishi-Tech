public with sharing class IncomeTriggerHandler {
    public static void updateCropCycleTotals(Set<Id> cropCycleIds) {
        Map<Id, Decimal> incomeTotals = new Map<Id, Decimal>();
        
        for (AggregateResult ar : [
            SELECT Crop_Cycle__c, SUM(Amount__c) total
            FROM Income__c
            WHERE Crop_Cycle__c IN :cropCycleIds
            GROUP BY Crop_Cycle__c
        ]) {
            Id cycleId = (Id)ar.get('Crop_Cycle__c');
            Decimal total = (Decimal)ar.get('total');
            incomeTotals.put(cycleId, total);
        }
        
        List<Crop_Cycle__c> cyclesToUpdate = [
            SELECT Id, Total_Revenue__c
            FROM Crop_Cycle__c
            WHERE Id IN :cropCycleIds
        ];
        
        for (Crop_Cycle__c cycle : cyclesToUpdate) {
            cycle.Total_Revenue__c = incomeTotals.containsKey(cycle.Id) 
                ? incomeTotals.get(cycle.Id) 
                : 0;
        }
        
        if (!cyclesToUpdate.isEmpty()) {
            update cyclesToUpdate;
        }
    }
}
