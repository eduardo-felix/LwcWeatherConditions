public with sharing class WeatherAPI {
    @AuraEnabled (cacheable=true)
    public static string getWeatherData(String cityName){
        try { 
            String apiKey = '0b10f96be99dfd63499c923548ce9abe';
            String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q='+cityName+'&appid='+apiKey;
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(apiUrl);
            req.setMethod('GET');
            HttpResponse res = h.send(req);
            return res.getBody();            

        } catch (Exception e) {
            System.debug('ERRROO');
            throw new AuraHandledException(e.getMessage());
        }
    }
}