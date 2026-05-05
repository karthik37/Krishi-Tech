Map<String, Schema.SObjectField> fields = Schema.SObjectType.Tree_Asset__c.fields.getMap();
for (String fieldName : fields.keySet()) {
    System.debug('Field: ' + fieldName);
}
