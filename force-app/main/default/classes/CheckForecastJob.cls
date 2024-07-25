public with sharing class CheckForecastJob {
   
public static void postNotification(){
    List<Date> holydaysList = ForecastService.getHolydays();

    List<Pacient__c> pacientsWithProblems = [
            SELECT Id, Name
            FROM Pacient__c
            WHERE cita__c IN :holydaysList
        ];

// Iterar sobre los profesionales con problemas y enviar notificaciones
for (Pacient__c pacientWithProblem : pacientsWithProblems) {
    try {
        CustomNotificationType notificationType = [
            SELECT Id, DeveloperName 
            FROM CustomNotificationType 
            WHERE DeveloperName = 'dateAlert'
        ];

        // Crear una nueva notificación personalizada
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        setNotificationMessage(notification, pacientWithProblem);


        // Set the notification type and target
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(pacientWithProblem.Id);
        //Set<String> addressee = new Set<String>();
        //addressee.add(professionalWithProblem.OwnerId);
        notification.send(new Set<String>{UserInfo.getUserId()});
    } catch (Exception e) {
        System.debug('Problem sending notification: ' + e.getMessage());
    }

    //Send a plataform event
    System.debug('Antes de publicar platform event');
    Pacient_with_Problem__e pacientWithProblemEvent = new Pacient_with_Problem__e(Pacient_Id__c=pacientWithProblem.Id);
    
    List<Pacient_with_Problem__e> pacientWithProblemEvents = new List<Pacient_with_Problem__e>();
    pacientWithProblemEvents.add(pacientWithProblemEvent);

    // Call method to publish events
    List<Database.SaveResult> results = EventBus.publish(pacientWithProblemEvents);

    // Inspect publishing result for each event
    for (Database.SaveResult sr : results) {
        if (sr.isSuccess()) {
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' +
                            err.getStatusCode() +
                            ' - ' +
                            err.getMessage());
            }
        }       
    }
    }
    }

private static void setNotificationMessage(
    Messaging.CustomNotification notification,
    Pacient__c pacient
){
    notification.setTitle('Es feriado');
    notification.setBody(
            'Reagendar al paciente ' + pacient.Name + ' ese día es feriado'
        );
}


}