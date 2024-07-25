public with sharing class ProfesionalService {
    @AuraEnabled(cacheable=true)
    public static List<professional__c> getFilteredProfesionals(String searchText) {
        String likeValue = '%' + searchText + '%';
        return [
            SELECT Id, Name, Description__c, Image_URL__c, schedules__c
            FROM professional__c
            WHERE Name LIKE :likeValue
        ];
    }

    @AuraEnabled()
    public static void createProfesionalWithPacient(
        String profesionalName,
        String pacientName,
        String profesionalSchedule
        ){
        //Crear Profesional
        professional__c newProfessional = new professional__c();
        newProfessional.Name = profesionalName;
        newProfessional.Schedules__c = profesionalSchedule;
        insert newProfessional;

        //Crear paciente 
        Pacient__c newPacient = new Pacient__c();
        newPacient.Name = pacientName;
        insert newPacient;

    }
}
