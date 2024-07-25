public with sharing class TestTransaction {
  public static void test() {
    Account acct = new Account(Name = 'TRX test');
    insert acct;

    throw new MyException();
  }
}
