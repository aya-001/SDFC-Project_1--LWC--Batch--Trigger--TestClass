@isTest
private class SampleProductionUtilTest {

    //取引先が見つかる場合のテスト

    @isTest
    static void unitTest01() {
        //テストの準備

        System.debug('■■テスト準備■■');
        Account acc = new Account(Name='sample01');
        insert acc;

        //テストの実施
        test.startTest();
        SampleProductionUtil util = new SampleProductionUtil();
        util.createHideyaContact(acc.id);
        Test.stopTest();

        //テストの検証
        List<Account> result = 
        [select Id,(select LastName, FirstName from Contacts)
        from Account where Id =: acc.Id];
        System.assert(result[0].Contacts.size() == 1);
        System.assert(result[0].Contacts[0].LastName == '斎藤');
        System.assert(result[0].Contacts[0].FirstName == '秀哉');

        /* Lust<Contact> result2 =
        [select LastName, FirstName 
        from Contact where AccountId =: acc.Id];
        System.assert(result2[0].size() == 1);
        System.assert(result2[0].LastName == '斎藤');
        System.assert(result2[0].FirstName == '秀哉');
 */

    }

    //取引先が見つからない場合のテスト

    @isTest
    static void unitTest02() {
        //テストの準備
        //なし

        //テストの実施
        test.startTest();
        SampleProductionUtil util = new SampleProductionUtil();
        util.createHideyaContact(null);
        Test.stopTest();

        //テストの検証
        List<Account> result = 
        [select Id,
        (select LastName, FirstName from Contacts)
        from Account where Name = 'dummy'];
        System.assert(result.size() == 1);
        System.assert(result[0].Contacts.size() == 1);
        System.assert(result[0].Contacts[0].LastName == '斎藤');
        System.assert(result[0].Contacts[0].FirstName == '秀哉');

        /* Lust<Contact> result2 =
        [select LastName, FirstName 
        from Contact where AccountId =: acc.Id];
        System.assert(result2[0].size() == 1);
        System.assert(result2[0].LastName == '斎藤');
        System.assert(result2[0].FirstNamw == '秀哉');
 */

    }
}