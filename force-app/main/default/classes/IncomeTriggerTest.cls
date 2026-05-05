@isTest
private class IncomeTriggerTest {
    @isTest
    static void testIncomeRollup() {
        // Setup
        Farm_Bed__c bed = new Farm_Bed__c(Name = 'Test Bed', Status__c = 'Active');
        insert bed;
        
        Crop_Cycle__c cycle = new Crop_Cycle__c(
            Farm_Bed__c = bed.Id,
            Status__c = 'Planned',
            Total_Revenue__c = 0
        );
        insert cycle;
        
        // Test Insert
        Income__c inc1 = new Income__c(
            Crop_Cycle__c = cycle.Id,
            Amount__c = 200,
            Date__c = Date.today()
        );
        insert inc1;
        
        cycle = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(200, cycle.Total_Revenue__c, 'Total Revenue should be 200 after insert');
        
        // Test Update
        inc1.Amount__c = 250;
        update inc1;
        
        cycle = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(250, cycle.Total_Revenue__c, 'Total Revenue should be 250 after update');
        
        // Test Delete
        delete inc1;
        
        cycle = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(0, cycle.Total_Revenue__c, 'Total Revenue should be 0 after delete');
    }
}
