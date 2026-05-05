// Data Import Script for Krishi Tech
Savepoint sp = Database.setSavepoint();
try {
    // 1. Accounts
    List<Account> accs = new List<Account>();
    accs.add(new Account(Name='Anantapur Seed Suppliers', Type='Supplier - Seeds/Saplings', Phone='9123456789', BillingCity='Anantapur', Preferred_Payment_Terms__c='7 Days Credit', Quality_Rating__c='Good', GST_Number__c='37XXXXX1234Z5', External_ID__c='ACC-001'));
    accs.add(new Account(Name='Green Fertilizers Pvt Ltd', Type='Supplier - Fertilizer', Phone='9123456790', BillingCity='Anantapur', Preferred_Payment_Terms__c='15 Days Credit', Quality_Rating__c='Excellent', GST_Number__c='37XXXXX5678Z9', External_ID__c='ACC-002'));
    accs.add(new Account(Name='Farm Equipment Store', Type='Supplier - Equipment', Phone='9123456791', BillingCity='Anantapur', Preferred_Payment_Terms__c='Immediate Cash', Quality_Rating__c='Good', GST_Number__c='37XXXXX9012Z3', External_ID__c='ACC-003'));
    accs.add(new Account(Name='Bangalore Wholesale Market', Type='Buyer - Wholesale', Phone='9823456789', BillingCity='Bangalore', Preferred_Payment_Terms__c='7 Days Credit', Quality_Rating__c='Excellent', GST_Number__c='29XXXXX1111Z1', External_ID__c='ACC-004'));
    accs.add(new Account(Name='Organic Foods Direct', Type='Buyer - Retail', Phone='9823456790', BillingCity='Hyderabad', Preferred_Payment_Terms__c='15 Days Credit', Quality_Rating__c='Excellent', GST_Number__c='36XXXXX2222Z2', External_ID__c='ACC-005'));
    accs.add(new Account(Name='Local Vegetable Market', Type='Buyer - Wholesale', Phone='9123456792', BillingCity='Anantapur', Preferred_Payment_Terms__c='Immediate Cash', Quality_Rating__c='Good', External_ID__c='ACC-006'));
    upsert accs External_ID__c;
    System.debug('Inserted ' + accs.size() + ' Accounts');

    // 2. Contacts
    List<Contact> cons = new List<Contact>();
    cons.add(new Contact(FirstName='Ravi', LastName='Kumar', Email='ravi.kumar@example.com', Phone='9876543210', Worker_Type__c='Farm Manager', Daily_Wage_Rate__c=800, Skills__c='Irrigation Management;Planting;General Maintenance', Availability_Status__c='Available', Aadhaar_Number__c='123456789012', External_ID__c='CON-001'));
    cons.add(new Contact(FirstName='Suresh', LastName='Reddy', Phone='9876543211', Worker_Type__c='Permanent Worker', Daily_Wage_Rate__c=500, Skills__c='Planting;Harvesting', Availability_Status__c='Available', Aadhaar_Number__c='234567890123', External_ID__c='CON-002'));
    cons.add(new Contact(FirstName='Lakshmi', LastName='Devi', Phone='9876543212', Worker_Type__c='Permanent Worker', Daily_Wage_Rate__c=450, Skills__c='Planting;Weeding', Availability_Status__c='Available', Aadhaar_Number__c='345678901234', External_ID__c='CON-003'));
    cons.add(new Contact(FirstName='Ramesh', LastName='Naidu', Phone='9876543213', Worker_Type__c='Daily Wage Worker', Daily_Wage_Rate__c=400, Skills__c='General Maintenance', Availability_Status__c='Available', Aadhaar_Number__c='456789012345', External_ID__c='CON-004'));
    cons.add(new Contact(FirstName='Venkat', LastName='Rao', Phone='9876543214', Worker_Type__c='Seasonal Worker', Daily_Wage_Rate__c=450, Skills__c='Harvesting', Availability_Status__c='Available', Aadhaar_Number__c='567890123456', External_ID__c='CON-005'));
    // Correction for Lakshmi Devi
    for(Contact c : cons) { if(c.FirstName == 'Lakshmi') { c.LastName = 'Devi'; } }
    upsert cons External_ID__c;
    System.debug('Inserted ' + cons.size() + ' Contacts');

    // 3. Farm Beds
    List<Farm_Bed__c> beds = new List<Farm_Bed__c>();
    for(Integer i=1; i<=18; i++) {
        beds.add(new Farm_Bed__c(Name='Bed ' + i, Bed_Size_Acres__c=0.5, External_ID__c='FB-' + (i<10?'0':'') + i, Status_Force__c='Under Preparation'));
    }
    upsert beds External_ID__c;
    System.debug('Inserted/Updated ' + beds.size() + ' Farm Beds.');

    // 4. Inventory Items
    List<Inventory_Item__c> invs = new List<Inventory_Item__c>();
    invs.add(new Inventory_Item__c(Name='Sweet Potato Cuttings - Sree Bhadra', Category__c='Seeds', Unit__c='Pieces', Current_Stock__c=0, Minimum_Stock_Level__c=5000, Reorder_Quantity__c=10000, Unit_Cost__c=1.5, Preferred_Supplier__r=new Account(External_ID__c='ACC-001'), Location_Storage__c='Storage Room', External_ID__c='INV-001'));
    invs.add(new Inventory_Item__c(Name='NPK Fertilizer (19-19-19)', Category__c='Fertilizer - Chemical', Unit__c='Kg', Current_Stock__c=50, Minimum_Stock_Level__c=100, Reorder_Quantity__c=200, Unit_Cost__c=45, Preferred_Supplier__r=new Account(External_ID__c='ACC-002'), Location_Storage__c='Fertilizer Shed', External_ID__c='INV-002'));
    invs.add(new Inventory_Item__c(Name='FYM (Farmyard Manure)', Category__c='Fertilizer - Organic', Unit__c='Bags', Current_Stock__c=20, Minimum_Stock_Level__c=50, Reorder_Quantity__c=100, Unit_Cost__c=150, Location_Storage__c='Open Storage', External_ID__c='INV-003'));
    invs.add(new Inventory_Item__c(Name='Neem Oil (Pesticide)', Category__c='Pesticide - Organic', Unit__c='Liters', Current_Stock__c=5, Minimum_Stock_Level__c=10, Reorder_Quantity__c=20, Unit_Cost__c=450, Preferred_Supplier__r=new Account(External_ID__c='ACC-002'), Location_Storage__c='Storage Room', External_ID__c='INV-004'));
    invs.add(new Inventory_Item__c(Name='Drip Laterals (16mm)', Category__c='Irrigation Equipment', Unit__c='Meters', Current_Stock__c=0, Minimum_Stock_Level__c=500, Reorder_Quantity__c=1000, Unit_Cost__c=8, Preferred_Supplier__r=new Account(External_ID__c='ACC-003'), Location_Storage__c='Tool Shed', External_ID__c='INV-005'));
    invs.add(new Inventory_Item__c(Name='Spades', Category__c='Tools', Unit__c='Pieces', Current_Stock__c=10, Minimum_Stock_Level__c=5, Reorder_Quantity__c=10, Unit_Cost__c=250, Preferred_Supplier__r=new Account(External_ID__c='ACC-003'), Location_Storage__c='Tool Shed', External_ID__c='INV-006'));
    invs.add(new Inventory_Item__c(Name='Pruning Shears', Category__c='Tools', Unit__c='Pieces', Current_Stock__c=5, Minimum_Stock_Level__c=3, Reorder_Quantity__c=5, Unit_Cost__c=400, Preferred_Supplier__r=new Account(External_ID__c='ACC-003'), Location_Storage__c='Tool Shed', External_ID__c='INV-007'));
    invs.add(new Inventory_Item__c(Name='Turmeric Rhizomes', Category__c='Seeds', Unit__c='Kg', Current_Stock__c=0, Minimum_Stock_Level__c=500, Reorder_Quantity__c=1000, Unit_Cost__c=120, Preferred_Supplier__r=new Account(External_ID__c='ACC-001'), Location_Storage__c='Storage Room', External_ID__c='INV-008'));
    invs.add(new Inventory_Item__c(Name='Coconut Saplings - COD', Category__c='Saplings', Unit__c='Pieces', Current_Stock__c=0, Minimum_Stock_Level__c=50, Reorder_Quantity__c=100, Unit_Cost__c=700, Preferred_Supplier__r=new Account(External_ID__c='ACC-001'), Location_Storage__c='Nursery Area', External_ID__c='INV-009'));
    invs.add(new Inventory_Item__c(Name='Mango Saplings - Alphonso', Category__c='Saplings', Unit__c='Pieces', Current_Stock__c=0, Minimum_Stock_Level__c=50, Reorder_Quantity__c=100, Unit_Cost__c=450, Preferred_Supplier__r=new Account(External_ID__c='ACC-001'), Location_Storage__c='Nursery Area', External_ID__c='INV-010'));
    upsert invs External_ID__c;
    System.debug('Inserted ' + invs.size() + ' Inventory Items');

    // 5. Crop Cycles
    List<Crop_Cycle__c> cycles = new List<Crop_Cycle__c>();
    for(Integer i=1; i<=6; i++) {
        cycles.add(new Crop_Cycle__c(External_ID__c='B'+i+'-SP-Y0', Farm_Bed__r=new Farm_Bed__c(External_ID__c='FB-0'+i), Crop_Type__c='Sweet Potato', Variety__c='Sree Bhadra', Planting_Date__c=Date.newInstance(2026,6,15), Expected_Harvest_Date__c=Date.newInstance(2026,10,15), Quantity_Planted__c=6000, Unit_of_Measurement__c='Cuttings', Expected_Yield_kg__c=5000, Status__c='Planned'));
    }
    // Adjust dates for cycles 4-6
    for(Integer i=3; i<6; i++) { cycles[i].Planting_Date__c = Date.newInstance(2026,6,22); cycles[i].Expected_Harvest_Date__c = Date.newInstance(2026,10,22); }
    upsert cycles External_ID__c;
    System.debug('Inserted ' + cycles.size() + ' Crop Cycles');

    // 6. Expenses
    List<Expense__c> exps = new List<Expense__c>();
    exps.add(new Expense__c(External_ID__c='EXP-001', Crop_Cycle__r=new Crop_Cycle__c(External_ID__c='B1-SP-Y0'), Category__c='Seeds/Saplings', Date__c=Date.newInstance(2026,6,10), Amount__c=9000, Quantity_Used__c=6000, Unit__c='cuttings', Vendor_Supplier__r=new Account(External_ID__c='ACC-001'), Payment_Status__c='Paid', Payment_Method__c='UPI'));
    exps.add(new Expense__c(External_ID__c='EXP-002', Crop_Cycle__r=new Crop_Cycle__c(External_ID__c='B1-SP-Y0'), Category__c='Labor - Planting', Date__c=Date.newInstance(2026,6,12), Amount__c=3600, Quantity_Used__c=3, Unit__c='days', Payment_Status__c='Paid', Payment_Method__c='Cash'));
    exps.add(new Expense__c(External_ID__c='EXP-003', Crop_Cycle__r=new Crop_Cycle__c(External_ID__c='B1-SP-Y0'), Category__c='Fertilizer', Date__c=Date.newInstance(2026,6,13), Amount__c=600, Quantity_Used__c=200, Unit__c='kg', Payment_Status__c='Paid', Payment_Method__c='Cash'));
    exps.add(new Expense__c(External_ID__c='EXP-004', Crop_Cycle__r=new Crop_Cycle__c(External_ID__c='B1-SP-Y0'), Category__c='Irrigation - Equipment', Date__c=Date.newInstance(2026,6,14), Amount__c=4000, Vendor_Supplier__r=new Account(External_ID__c='ACC-003'), Payment_Status__c='Pending'));
    upsert exps External_ID__c;
    System.debug('Inserted ' + exps.size() + ' Expenses');

    // 7. Farm Tasks
    List<Farm_Task__c> tasks = new List<Farm_Task__c>();
    tasks.add(new Farm_Task__c(
        Task_Name__c='Initial Watering',
        Priority__c='Medium',
        Status_Force__c='Not Started',
        Task_Type__c='Watering',
        External_ID__c='FT-01'
    ));
    tasks.add(new Farm_Task__c(
        Task_Name__c='Weeding Row 1',
        Priority__c='High',
        Status_Force__c='Not Started',
        Task_Type__c='Weeding',
        External_ID__c='FT-02'
    ));
    tasks.add(new Farm_Task__c(External_ID__c='TSK-003', Task_Name__c='Soil Test - All Beds', Task_Type__c='Soil Testing', Farm_Bed__r=new Farm_Bed__c(External_ID__c='FB-01'), Crop_Cycle__r=new Crop_Cycle__c(External_ID__c='B1-SP-Y0'), Due_Date__c=Date.newInstance(2026,4,10), Priority__c='High', Status_Force__c='Not Started', Notes__c='Get comprehensive soil test before major planting'));
    upsert tasks External_ID__c;
    System.debug('Inserted ' + tasks.size() + ' Farm Tasks');

    // 8. Tree Assets
    List<Tree_Asset__c> trees = new List<Tree_Asset__c>();
    for(Integer i=1; i<=10; i++) {
        trees.add(new Tree_Asset__c(External_ID__c='TREE-'+(i<10?'0':'')+i, Tree_Type__c='Coconut', Variety__c='Chowghat Orange Dwarf', Planting_Date__c=Date.newInstance(2026,7,1), Location_Row_Column__c='Border-N-'+(i<10?'0':'')+i, Health_Status__c='Excellent', Producing_Status__c='Not Yet Producing', Notes__c='North border tree ' + i));
    }
    upsert trees External_ID__c;
    System.debug('Inserted ' + trees.size() + ' Tree Assets');

} catch(Exception e) {
    Database.rollback(sp);
    System.debug('ERROR: ' + e.getMessage());
    throw e;
}
