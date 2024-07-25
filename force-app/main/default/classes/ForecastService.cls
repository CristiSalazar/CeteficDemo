public with sharing class ForecastService {
    
    public static List<Date> holydaysList = new List<Date>();  // Lista para almacenar los días feriados
    
    public static List<Date> getHolydays() {
        HttpRequest req = new HttpRequest();        
        req.setEndpoint('callout:Holyday/fl/feriados/2024');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            List<Object> responseData = (List<Object>) JSON.deserializeUntyped(res.getBody());           
            for (Object recordData : responseData) {
                Map<String, Object> holydayData = (Map<String, Object>) recordData;
                String holydayDayString = (String) holydayData.get('fecha');
                
                // Parsear el string a Date
                Date holydayDate = Date.valueOf(holydayDayString);
                
                holydaysList.add(holydayDate);  // Agregamos cada día feriado a la lista
            }
        }

        return holydaysList;
    }  
}
