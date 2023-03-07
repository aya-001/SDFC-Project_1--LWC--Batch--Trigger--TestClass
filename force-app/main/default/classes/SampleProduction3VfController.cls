public with sharing class SampleProduction3VfController {

    public Account acc {get; set;}

    public SampleProduction3VfController (){
        Map<String, String> params = ApexPages.CurrentPage().getParameters();
        Id accId = (Id)params.get('id');
        if(String.isNotBlank(accId)){
        Account[] accounts = [SELECT Name FROM Account WHERE Id =: accId];
        acc = accounts[0];
        }
    }

    public PageReference moveDetailPage(){
        return new PageReference('/' + acc.Id);
    }
}