public with sharing class profesionalTriggerHandler {
  public static void beforeInsert(List<Pacient__c> newPacients) {
    Set<Id> pacientIds = new Set<Id>();
    for (Pacient__c p : newPacients) {
      pacientIds.add(p.Id);
    }
    if (!pacientIds.isEmpty()) {
      Map<Id, Pacient__c> pacientsById = preloadPacients(pacientIds);
      for (Pacient__c p : newPacients) {
        if (pacientsById.containsKey(p.Id)) {
          populateNextVisit(p, pacientsById.get(p.Id));
        }
      }
    }
  }

  public static void beforeUpdate(
    List<Pacient__c> oldPacients,
    Map<Id, Pacient__c> oldPacientsMap,
    List<Pacient__c> updatedPacients,
    Map<Id, Pacient__c> updatedPacientsMap
  ) {
    Set<Id> pacientIds = new Set<Id>();
    for (Pacient__c p : updatedPacients) {
      if (oldPacientsMap.containsKey(p.Id)) {
        if (
          oldPacientsMap.get(p.Id).Visit_frecuency__c != p.Visit_frecuency__c
        ) {
          pacientIds.add(p.Id);
        }
      }
    }

    if (!pacientIds.isEmpty()) {
      Map<Id, Pacient__c> pacientsById = preloadPacients(pacientIds);
      for (Pacient__c p : updatedPacients) {
        if (pacientsById.containsKey(p.Id)) {
          populateNextVisit(p, pacientsById.get(p.Id));
        }
      }
    }
  }

  private static Map<Id, Pacient__c> preloadPacients(Set<Id> pacientIds) {
    List<Pacient__c> pacients = [
      SELECT Id, Last_Visit__c, Visit_frecuency__c
      FROM Pacient__c
      WHERE Id IN :pacientIds
    ];

    Map<Id, Pacient__c> pacientsById = new Map<Id, Pacient__c>();
    for (Pacient__c p : pacients) {
      pacientsById.put(p.Id, p);
    }

    return pacientsById;
  }

  private static void populateNextVisit(
    Pacient__c pacient,
    Pacient__c oldPacient
  ) {
    if (pacient.Last_Visit__c != null && pacient.Visit_frecuency__c != null) {
      Integer daysToAdd = FrecuencyService.getScheduleDays(pacient);
      pacient.Next_Visit__c = pacient.Last_Visit__c.addDays(daysToAdd);
    } else {
      // Handle null values or provide default behavior if necessary
    }
  }
}
