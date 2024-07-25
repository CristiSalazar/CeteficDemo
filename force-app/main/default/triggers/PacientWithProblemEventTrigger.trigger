trigger PacientWithProblemEventTrigger on Pacient_with_Problem__e (after insert) {    
    System.debug('Suscriptor Apex');
    System.debug(Trigger.new);

    Account acct = new Account(Name = 'TRX test');
        insert acct;
        throw new  MyException();    
}