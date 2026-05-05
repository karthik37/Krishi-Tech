public with sharing class WhatsAppService {
    private static Twilio_Settings__c settings {
        get {
            return Twilio_Settings__c.getOrgDefaults();
        }
    }
    
    @InvocableMethod(label='Send WhatsApp Message' description='Sends a WhatsApp message via Twilio')
    public static void sendWhatsAppMessages(List<String> combinedParams) {
        // Expected format: "toNumber|message"
        for (String param : combinedParams) {
            String[] parts = param.split('\\|', 2);
            if (parts.size() == 2) {
                sendMessageFuture(parts[0], parts[1]);
            }
        }
    }

    @future(callout=true)
    private static void sendMessageFuture(String toNumber, String message) {
        if (settings == null || String.isBlank(settings.Account_SID__c) || String.isBlank(settings.Auth_Token__c)) {
            System.debug('Twilio Settings are missing.');
            return;
        }

        String endpoint = 'https://api.twilio.com/2010-04-01/Accounts/' + 
                         settings.Account_SID__c + '/Messages.json';
        
        String body = 'To=whatsapp:' + toNumber + 
                     '&From=whatsapp:' + settings.From_Number__c + 
                     '&Body=' + EncodingUtil.urlEncode(message, 'UTF-8');
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Blob headerValue = Blob.valueOf(settings.Account_SID__c + ':' + settings.Auth_Token__c);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setBody(body);
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            System.debug('Twilio Response: ' + res.getBody());
        } catch (Exception e) {
            System.debug('Twilio Error: ' + e.getMessage());
        }
    }
}
