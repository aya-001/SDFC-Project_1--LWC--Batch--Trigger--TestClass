public with sharing class TableViewController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
            return [SELECT Id, Name, Website, Phone, LastModifiedDate
                                FROM Account LIMIT 10];
    }
}