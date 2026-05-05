Schema.DescribeSObjectResult dr = Tree_Asset__c.sObjectType.getDescribe();
System.debug('FIELD_EXISTS: ' + dr.fields.getMap().containsKey('Tree_Type__c'));
System.debug('FIELD_KEYSET: ' + dr.fields.getMap().keySet());
