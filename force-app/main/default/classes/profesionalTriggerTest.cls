@isTest
private with sharing class profesionalTriggerTest {

    @isTest
    static void updatePacient_lastVisitSetUp_nextVisitCorrectly(){
        //Given
        Pacient__c pacient1 = new Pacient__c();
        pacient1.Visit_frecuency__c = 'Every other week';
        pacient1.Last_Visit__c = System.today() -15;
        insert pacient1;

        //Then
        pacient1 = [SELECT Next_Visit__c, Last_Visit__c, Visit_frecuency__c FROM Pacient__c WHERE Id = :pacient1.Id];
        System.assertEquals(System.today(), pacient1.Next_Visit__c);
        pacient1.Last_Visit__c = System.today();

        // WHEN
        Test.startTest();
        update pacient1;
        Test.stopTest();

        //Then
        pacient1 = [SELECT Next_Visit__c, Last_Visit__c, Visit_frecuency__c FROM Pacient__c WHERE Id = :pacient1.Id];
        System.assertEquals(System.today() + 15, pacient1.Next_Visit__c);
    }

}
