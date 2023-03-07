@isTest
private class SampleProduction1Test {

    @isTest
    static void unitTest01() {
        System.debug('unitTest01を開始します');
        Test.startTest();
        SampleProduction1 sp1 = new SampleProduction1();
        String message = sp1.checkNum(5);
        Test.stopTest();

        System.debug('■検証■');
        System.assertEquals('5は10未満です', message , 'メッセージが違います');
    }

    @isTest
    static void unitTest02() {
        System.debug('unitTest02を開始します');
        Test.startTest();
        SampleProduction1 sp1 = new SampleProduction1();
        String message = sp1.checkNum(13);
        Test.stopTest();

        System.debug('■検証■');
        System.assertEquals('13は10以上です', message , 'メッセージが違います');
    }
}