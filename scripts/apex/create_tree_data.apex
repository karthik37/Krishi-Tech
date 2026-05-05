delete [SELECT Id FROM Tree_Asset__c];

List<Tree_Asset__c> trees = new List<Tree_Asset__c>();
trees.add(new Tree_Asset__c(Tree_Type__c='Fruit', Variety__c='Apple', Health_Status__c='Healthy'));
trees.add(new Tree_Asset__c(Tree_Type__c='Nut', Variety__c='Almond', Health_Status__c='Needs Attention'));
trees.add(new Tree_Asset__c(Tree_Type__c='Timber', Variety__c='Teak', Health_Status__c='Healthy'));

insert trees;
System.debug('Tree Assets created successfully.');
