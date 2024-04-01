@isTest
public class WeatherAPITest {
    public class WeatherAPIMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"weather":[{"description":"clear sky"}],"main":{"temp":293.15}}');
            res.setStatusCode(200);
            return res;
        }
    }

    static testMethod void testGetWeatherData() {
        Test.setMock(HttpCalloutMock.class, new WeatherAPIMock());
        String cityName = 'London';
        String result = WeatherAPI.getWeatherData(cityName);
        System.assert(result.contains('clear sky'));
        System.assert(result.contains('293.15'));
    }
}