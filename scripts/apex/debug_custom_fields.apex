Map<String, Schema.SObjectField> fields = Schema.SObjectType.Tree_Asset__c.fields.getMap();
for (String fieldName : fields.keySet()) {
    if (fieldName.endsWith('__c')) {
        System.debug('CUSTOM_FIELD: ' + fieldName);
    }
}
