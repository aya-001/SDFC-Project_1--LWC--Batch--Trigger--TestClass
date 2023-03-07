public with sharing class AccountInsertController {
    @AuraEnabled
    public static Account createAccRec(Account acc){
            insert acc;
            return acc;
    }
}