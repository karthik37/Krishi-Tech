public with sharing class ScheduledWeatherFetch implements Schedulable {
    public void execute(SchedulableContext sc) {
        WeatherService.fetchWeatherData('Anantapur');
    }
}
