@isTest
private class FrecuencyServiceTest {
    @isTest
    static void getScheduleDays_visitfreqWeekly(){
        //Given -- Creación de datos, escenario 
        Pacient__c pacient = new Pacient__c();
        pacient.Visit_frecuency__c = 'Weekly';

        //When -- Llamamos al método
        Integer days = FrecuencyService.getScheduleDays(pacient);

        //Then -- Chequear el resultado esperado
        Integer expectedDays = 7;
        System.assertEquals(expectedDays, days, 'Expected 1 day returned');
    }

    @isTest
    static void getScheduleDays_visitfreqEveryOtherWeek(){
        //Given -- Creación de datos, escenario 
        Pacient__c pacient = new Pacient__c();
        pacient.Visit_frecuency__c = 'Every other week';

        //When -- Llamamos al método
        Integer days = FrecuencyService.getScheduleDays(pacient);

        //Then -- Chequear el resultado esperado
        Integer expectedDays = 14;
        System.assertEquals(expectedDays, days, 'Expected 14 day returned');
    }
}