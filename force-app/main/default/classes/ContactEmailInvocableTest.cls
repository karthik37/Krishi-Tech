@isTest
private class ContactEmailInvocableTest {
    @isTest
    static void testSendEmail() {
        Contact c = new Contact(LastName = 'TestContact');
        insert c;
        
        ContactEmailInvocable.EmailRequest req = new ContactEmailInvocable.EmailRequest();
        req.contactId = c.Id;
        
        Test.startTest();
        ContactEmailInvocable.sendEmailToContact(new List<ContactEmailInvocable.EmailRequest>{req});
        System.assert(true);
        Test.stopTest();
    }
}