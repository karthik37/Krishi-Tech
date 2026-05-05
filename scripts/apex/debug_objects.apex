for(Schema.SObjectType t : Schema.getGlobalDescribe().values()){
    if(t.getDescribe().isCustom() && t.getDescribe().getName().contains('__c')){
        System.debug('OBJECT_NAME: ' + t.getDescribe().getName());
    }
}
