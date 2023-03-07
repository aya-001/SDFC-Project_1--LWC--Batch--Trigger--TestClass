public with sharing class SampleProductionUtil{

    public void createHideyaContact(Id parentAccId){
        Contact con = new Contact(LastName    = '斉藤',
                                                            FirstName = '秀哉',
                                                            AccountId = null);

        Account[] accounts = [SELECT Id,Name FROM Account WHERE Id =:parentAccId];

        if(1 <= accounts.size()){
            con.AccountId = accounts[0].Id;
        } else {
            Account acc = new Account(Name='dummy');
            insert acc;
            con.AccountId = acc.Id;
        }
        insert con;
    }
}