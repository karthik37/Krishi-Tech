@isTest
private class CropCycleRollupServiceTest {
    @TestSetup
    static void setup() {
        Farm_Bed__c bed = new Farm_Bed__c(Name='Test Bed', Status__c='Planted');
        insert bed;
        
        Crop_Cycle__c cc = new Crop_Cycle__c(
            Farm_Bed__c = bed.Id,
            Crop_Type__c = 'Tomato',
            Planting_Date__c = System.today(),
            Expected_Harvest_Date__c = System.today().addDays(60)
        );
        insert cc;
    }
    
    @isTest
    static void testExpenseRollup() {
        Crop_Cycle__c cc = [SELECT Id FROM Crop_Cycle__c LIMIT 1];
        
        Expense__c e1 = new Expense__c(
            Crop_Cycle__c = cc.Id,
            Category__c = 'Labor',
            Date__c = System.today(),
            Amount__c = 100
        );
        Expense__c e2 = new Expense__c(
            Crop_Cycle__c = cc.Id,
            Category__c = 'Seeds',
            Date__c = System.today(),
            Amount__c = 50
        );
        insert new List<Expense__c>{e1, e2};
        
        cc = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(150, cc.Total_Input_Cost__c);
        
        e1.Amount__c = 120;
        update e1;
        
        cc = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(170, cc.Total_Input_Cost__c);
        
        delete e2;
        
        cc = [SELECT Total_Input_Cost__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(120, cc.Total_Input_Cost__c);
    }
    
    @isTest
    static void testIncomeRollup() {
        Crop_Cycle__c cc = [SELECT Id FROM Crop_Cycle__c LIMIT 1];
        
        Income__c i1 = new Income__c(
            Crop_Cycle__c = cc.Id,
            Sale_Source__c = 'Wholesale Market',
            Date__c = System.today(),
            Amount__c = 500
        );
        insert i1;
        
        cc = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(500, cc.Total_Revenue__c);
        
        i1.Amount__c = 600;
        update i1;
        
        cc = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(600, cc.Total_Revenue__c);
        
        delete i1;
        
        cc = [SELECT Total_Revenue__c FROM Crop_Cycle__c WHERE Id = :cc.Id];
        System.assertEquals(0, cc.Total_Revenue__c);
    }
}