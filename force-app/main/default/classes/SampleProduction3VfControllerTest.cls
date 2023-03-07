@isTest
private class SampleProduction3VfControllerTest {

    @isTest
    static void myUnitTest8_2() {
        System.debug('■■テスト準備■■');
           // 現在のページを作成して、URLパラメータに取引先Idをセット
        PageReference pageRef = Page.SampleProduction3Vf;
        Test.setCurrentPage(pageRef);

        System.debug('■■テスト実行■■');
        Test.startTest();
        // コントローラのコンストラクタ作成
        SampleProduction3VfController ctrl = new SampleProduction3VfController();
        // 画面移動メソッドを呼んで移動先を取得
        PageReference goToPage = ctrl.moveDetailPage();
        Test.stopTest();

        System.debug('■■テスト検証■■');
        

    }


    @isTest
    static void myUnitTest() {
        System.debug('■■テスト準備■■');
        Account newAcc = new Account(Name='sample');
        insert newAcc;

        // 現在のページを作成して、URLパラメータに取引先Idをセット
        PageReference pageRef = Page.SampleProduction3Vf;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', newAcc.Id);

        System.debug('■■テスト実行■■');
        Test.startTest();
        // コントローラのコンストラクタ作成
        SampleProduction3VfController ctrl = new SampleProduction3VfController();
        // 画面移動メソッドを呼んで移動先を取得
        PageReference goToPage = ctrl.moveDetailPage();
        Test.stopTest();

        System.debug('■■テスト検証■■');
        // コントローラのプロパティとURLセットした取引先が同じ
        System.assertEquals(newAcc.Name, ctrl.acc.Name);
        // 遷移先の確認
        System.assertEquals('/' + newAcc.Id, goToPage.getUrl());
        //URLパラメータのＩｄがない
        System.assertEquals(newAcc.Id, null);
    }
}