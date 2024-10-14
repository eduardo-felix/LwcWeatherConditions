public with sharing class WeatherAPI {
    @AuraEnabled (cacheable=true)
    public static string getWeatherData(String cityName){
        try { 
            system.debug(cityName);           
            String apiKey = '0b10f96be99dfd63499c923548ce9abe';
            String encodedCityName = EncodingUtil.urlEncode(cityName, 'UTF-8');
            String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q='+encodedCityName+'&appid='+apiKey;
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(apiUrl);
            req.setMethod('GET');
            HttpResponse res = h.send(req);
            if (res.getStatusCode() == 200) {
                return res.getBody();
            } else {                
                throw new AuraHandledException('Erro ao buscar dados de clima: ' + res.getStatusCode() + ' - ' + res.getStatus());
            }                        

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}