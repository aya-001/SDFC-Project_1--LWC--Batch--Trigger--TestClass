public with sharing class SampleProduction2 {

    public List<Account> searchAccountByName(String nm){
        Account[] accounts = [SELECT Name FROM Account WHERE Name =: nm];
        return accounts;
    }
}