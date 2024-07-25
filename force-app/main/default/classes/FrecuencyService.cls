public with sharing class FrecuencyService {
 static Map<String, Integer> daysByFrecuency = new Map<String, Integer>();

 static{
    daysByFrecuency.put('Weekly', 7);
    daysByFrecuency.put('Every other week', 14);
    daysByFrecuency.put('Monthly', 30);
    daysByFrecuency.put('Every three months', 90);
 }

    public static Integer getScheduleDays(Pacient__c pacient) {
        return daysByFrecuency.get(pacient.Visit_frecuency__c);
    }
}