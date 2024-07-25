@RestResource(urlMapping='/checkForecast')
global with sharing class ForecastRestApi {
  @HttpGet
  global static void doGet() {
    //RestRequest req = RestContext.request;
    //RestResponse res = RestContext.response;
    CheckForecastJob.postNotification();
  }
}
