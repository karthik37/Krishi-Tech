public with sharing class CropCycleRollupService {
    public static void recalculateRollups(Set<Id> cropCycleIds) {
        if (cropCycleIds.isEmpty()) return;
        
        // Query to get the aggregate sums of Income
        Map<Id, Decimal> revenueMap = new Map<Id, Decimal>();
        for (AggregateResult ar : [SELECT Crop_Cycle__c, SUM(Amount__c) amt FROM Income__c WHERE Crop_Cycle__c IN :cropCycleIds GROUP BY Crop_Cycle__c]) {
            revenueMap.put((Id)ar.get('Crop_Cycle__c'), (Decimal)ar.get('amt'));
        }
        
        // Query to get the aggregate sums of Expense
        Map<Id, Decimal> costMap = new Map<Id, Decimal>();
        for (AggregateResult ar : [SELECT Crop_Cycle__c, SUM(Amount__c) amt FROM Expense__c WHERE Crop_Cycle__c IN :cropCycleIds GROUP BY Crop_Cycle__c]) {
            costMap.put((Id)ar.get('Crop_Cycle__c'), (Decimal)ar.get('amt'));
        }
        
        List<Crop_Cycle__c> toUpdate = new List<Crop_Cycle__c>();
        for (Id ccId : cropCycleIds) {
            toUpdate.add(new Crop_Cycle__c(
                Id = ccId,
                Total_Revenue__c = revenueMap.containsKey(ccId) ? revenueMap.get(ccId) : 0,
                Total_Input_Cost__c = costMap.containsKey(ccId) ? costMap.get(ccId) : 0
            ));
        }
        
        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}