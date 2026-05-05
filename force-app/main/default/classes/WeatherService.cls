public with sharing class WeatherService {
    private static String API_KEY {
        get {
            Weather_API_Settings__c settings = Weather_API_Settings__c.getOrgDefaults();
            return settings != null ? settings.API_Key__c : null;
        }
    }
    private static String API_URL = 'https://api.openweathermap.org/data/2.5/weather';
    
    @future(callout=true)
    public static void fetchWeatherData(String city) {
        if (String.isBlank(API_KEY)) {
            System.debug('Weather API Key is missing in Custom Settings.');
            return;
        }
        
        // Construct URL
        String url = API_URL + '?q=' + city + ',IN&appid=' + API_KEY + '&units=metric';
        
        // Make HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        
        try {
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                // Parse JSON response
                Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                Map<String, Object> main = (Map<String, Object>)results.get('main');
                
                // Create Weather Log record
                Weather_Log__c log = new Weather_Log__c();
                log.Date__c = Date.today();
                log.Temperature_Max_C__c = (Decimal)main.get('temp_max');
                log.Temperature_Min_C__c = (Decimal)main.get('temp_min');
                log.Humidity__c = (Decimal)main.get('humidity');
                
                // Check if rainfall data exists
                if (results.containsKey('rain')) {
                    Map<String, Object> rain = (Map<String, Object>)results.get('rain');
                    if (rain.containsKey('1h')) {
                        log.Rainfall_mm__c = (Decimal)rain.get('1h');
                    } else if (rain.containsKey('3h')) {
                         log.Rainfall_mm__c = (Decimal)rain.get('3h');
                    }
                }
                
                insert log;
            } else {
                System.debug('Weather API Error: ' + response.getStatusCode() + ' ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Weather Service Exception: ' + e.getMessage());
        }
    }
}
