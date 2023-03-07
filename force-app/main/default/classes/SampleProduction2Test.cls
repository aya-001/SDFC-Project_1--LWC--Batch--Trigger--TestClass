@isTest
private class SampleProduction2Test {

    // 検索が見つかるパターン
    @isTest
    static void searchFound() {
        System.debug('■■テスト準備■■');
        createTestData();

        System.debug('■■テスト実行■■');
        Test.startTest();
        SampleProduction2 sp2 = new SampleProduction2();
        Account[] results = sp2.searchAccountByName('有限会社ホタル');
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.assertEquals(1, results.size());
        System.assertEquals('有限会社ホタル', results[0].Name);
    }

    // 見つからないパターン
    @isTest
    static void searchNotFound() {
        System.debug('■■テスト準備■■');
        createTestData();

        System.debug('■■テスト実行■■');
        Test.startTest();
        SampleProduction2 sp2 = new SampleProduction2();
        Account[] results = sp2.searchAccountByName('株式会社ダウニー');
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.assertEquals(0, results.size());
    }

    // テストデータ準備
    static void createTestData(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='アオリ商事'));
        accounts.add(new Account(Name='有限会社ホタル'));
        insert accounts;
    }
}