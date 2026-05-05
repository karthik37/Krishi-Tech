@isTest
private class ExpenseTriggerTest {
    @isTest
    static void testExpenseRollup() {
        // Setup
        Farm_Bed__c bed = new Farm_Bed__c(Name = 'Test Bed', Status__c = 'Active');
        insert bed;
        
        Crop_Cycle__c cycle = new Crop_Cycle__c(
            Farm_Bed__c = bed.Id,
            Status__c = 'Planned',
            Total_Input_Cost__c = 0
        );
        insert cycle;
        
        // Test Insert
        Expense__c exp1 = new Expense__c(
            Crop_Cycle__c = cycle.Id,
            Amount__c = 100,
            Date__c = Date.today()
        );
        insert exp1;
        
        cycle = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(100, cycle.Total_Input_Cost__c, 'Total Input Cost should be 100 after insert');
        
        // Test Update
        exp1.Amount__c = 150;
        update exp1;
        
        cycle = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(150, cycle.Total_Input_Cost__c, 'Total Input Cost should be 150 after update');
        
        // Test Delete
        delete exp1;
        
        cycle = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cycle.Id];
        System.assertEquals(0, cycle.Total_Input_Cost__c, 'Total Input Cost should be 0 after delete');
    }
}
