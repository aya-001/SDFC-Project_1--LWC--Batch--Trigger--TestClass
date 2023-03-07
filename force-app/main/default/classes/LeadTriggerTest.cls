@isTest
private class LeadTriggerTest {

    @isTest
    static void myUnitTest() {
        System.debug('■■テスト準備■■');
        List<Lead> newLeads = new List<Lead>();
        newLeads.add(new Lead(Company='株式会社キット研修', LastName='栄木'));
        newLeads.add(new Lead(Company='株式会社Bee研修', LastName='広木'));

        System.debug('■■テスト実行■■');
        Test.startTest();
        // DMLでトリガを呼び出す
        Database.SaveResult[] results = Database.insert(newLeads, false);
        Test.stopTest();

        System.debug('■■テスト検証■■');
        // 1件目のFirstNameが変わっている検証
        System.debug(results[0]);
        System.assert(results[0].isSuccess());
        Lead afterSaveLead = [SELECT FirstName
                                                        FROM Lead WHERE Id =:newLeads[0].Id LIMIT 1];
        System.assertEquals('太郎', afterSaveLead.FirstName);

        // 2件目のエラーになる検証
        System.assert(! results[1].isSuccess());
        System.assertEquals('カスタムエラー',
                                                         results[1].getErrors()[0].getMessage());
    }
    @isTest
    static void bulkTest() {
        System.debug('■■テスト準備■■');
        List<Lead> newLeads = new List<Lead>();
        for(Integer i=0; i<201; i++){
            newLeads.add(new Lead(Company='company'+i, LastName='nm'+i));
        }

        System.debug('■■テスト実行■■');
        Test.startTest();
        insert newLeads;
        Test.stopTest();

        System.debug('■■テスト検証■■');
        // Exceptionが発生しないことが検証になるので省略
    }
}