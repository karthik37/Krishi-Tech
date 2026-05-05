// Clean up existing data and fix bad data for rollups first
List<Crop_Cycle__c> existingCycles = [SELECT Id, Actual_Yield_kg__c, Expected_Yield_kg__c FROM Crop_Cycle__c];
for (Crop_Cycle__c c : existingCycles) {
    if (c.Actual_Yield_kg__c != null && c.Expected_Yield_kg__c != null) {
        if (c.Actual_Yield_kg__c > c.Expected_Yield_kg__c * 1.5) {
            c.Expected_Yield_kg__c = c.Actual_Yield_kg__c;
        }
    }
}
update existingCycles;

delete [SELECT Id FROM Expense__c];
delete [SELECT Id FROM Income__c];
delete [SELECT Id FROM Farm_Task__c];
delete [SELECT Id FROM Crop_Cycle__c];
delete [SELECT Id FROM Farm_Bed__c];
delete [SELECT Id FROM Inventory_Item__c];

// 1. Create Farm Beds
List<Farm_Bed__c> beds = new List<Farm_Bed__c>();
beds.add(new Farm_Bed__c(Name='Bed A1', Status__c='Active'));
beds.add(new Farm_Bed__c(Name='Bed A2', Status__c='Fallow'));
beds.add(new Farm_Bed__c(Name='Bed B1', Status__c='Preparation'));
insert beds;

// 2. Create Inventory Items
List<Inventory_Item__c> items = new List<Inventory_Item__c>();
items.add(new Inventory_Item__c(Name='Tomato Seeds', Current_Stock__c=100, Minimum_Stock_Level__c=20));
items.add(new Inventory_Item__c(Name='NPK Fertilizer', Current_Stock__c=50, Minimum_Stock_Level__c=60)); // Low stock to trigger alert!
insert items;

// 3. Create Crop Cycles
List<Crop_Cycle__c> cycles = new List<Crop_Cycle__c>();
cycles.add(new Crop_Cycle__c(
    Farm_Bed__c = beds[0].Id,
    Status__c = 'In Progress',
    Planting_Date__c = Date.today().addDays(-30),
    Expected_Yield_kg__c = 500,
    Quantity_Planted__c = 100
));
cycles.add(new Crop_Cycle__c(
    Farm_Bed__c = beds[1].Id,
    Status__c = 'Completed',
    Planting_Date__c = Date.today().addDays(-90),
    Expected_Yield_kg__c = 400,
    Actual_Yield_kg__c = 450,
    Quantity_Planted__c = 80
));
insert cycles;

// 4. Create Expenses
List<Expense__c> expenses = new List<Expense__c>();
expenses.add(new Expense__c(
    Crop_Cycle__c = cycles[0].Id,
    Amount__c = 150.00,
    Date__c = Date.today().addDays(-15)
));
expenses.add(new Expense__c(
    Crop_Cycle__c = cycles[1].Id,
    Amount__c = 300.00,
    Date__c = Date.today().addDays(-60)
));
expenses.add(new Expense__c(
    Crop_Cycle__c = cycles[1].Id,
    Amount__c = 50.00,
    Date__c = Date.today().addDays(-40)
));
insert expenses;

// 5. Create Incomes
List<Income__c> incomes = new List<Income__c>();
incomes.add(new Income__c(
    Crop_Cycle__c = cycles[1].Id,
    Amount__c = 1200.00,
    Date__c = Date.today().addDays(-5)
));
insert incomes;

// 6. Create Farm Tasks
List<Farm_Task__c> tasks = new List<Farm_Task__c>();
tasks.add(new Farm_Task__c(
    Crop_Cycle__c = cycles[0].Id,
    Task_Name__c = 'Apply Fertilizer',
    Due_Date__c = Date.today().addDays(5),
    Status__c = 'Pending'
));
tasks.add(new Farm_Task__c(
    Crop_Cycle__c = cycles[0].Id,
    Task_Name__c = 'Weeding',
    Due_Date__c = Date.today().addDays(15),
    Status__c = 'Pending'
));
tasks.add(new Farm_Task__c(
    Crop_Cycle__c = cycles[1].Id,
    Task_Name__c = 'Post-Harvest Cleanup',
    Due_Date__c = Date.today().addDays(-2),
    Status__c = 'Pending'
));
insert tasks;

System.debug('Data creation completed successfully.');
