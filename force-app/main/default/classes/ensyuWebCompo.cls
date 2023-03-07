public with sharing class ensyuWebCompo {
  

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOppList(String accountId){
        return [SELECT Id, Name, StageName, Amount, CloseDate
                FROM Opportunity Where AccountId =: accountId
                ORDER BY Amount DESC];
  }
}