public with sharing class ContactEmailInvocable {
    
    @InvocableMethod(label='Send Email to Contact' description='Sends an email template to a specified Contact')
    public static void sendEmailToContact(List<EmailRequest> requests) {
        if (requests == null || requests.isEmpty()) return;
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for (EmailRequest req : requests) {
            if (req.contactId == null) continue;
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(req.contactId);
            if (req.templateId != null) {
                mail.setTemplateId(req.templateId);
            }
            if (req.whatId != null) {
                mail.setWhatId(req.whatId);
            }
            mail.setSaveAsActivity(req.saveAsActivity != null ? req.saveAsActivity : false);
            emails.add(mail);
        }
        
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails, false);
        }
    }
    
    public class EmailRequest {
        @InvocableVariable(label='Contact Id' required=true)
        public Id contactId;
        
        @InvocableVariable(label='Email Template Id' required=true)
        public Id templateId;
        
        @InvocableVariable(label='Related Record Id (WhatId)' required=false)
        public Id whatId;
        
        @InvocableVariable(label='Save as Activity' required=false)
        public Boolean saveAsActivity;
    }
}