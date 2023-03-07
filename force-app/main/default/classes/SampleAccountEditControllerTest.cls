@isTest
public with sharing class SampleAccountEditControllerTest {

    @isTest
    /*初期処理(正常系) */
    static void testDoInit() {
        System.debug('■■テスト準備■■');
        Account newAcc = createAccountData();

        List<Opportunity> newOpps = createOpportunityData(newAcc.id);

        // 現在のページを作成して、URLパラメータに取引先Idをセット
        PageReference pageRef = Page.SampleProduction3Vf;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', newAcc.Id);

        SampleAccountEditController ctrl = new SampleAccountEditController();
        
        System.debug('■■テスト実行■■');
        Test.startTest();
        ctrl.doinit();
        Test.stopTest();
       

        System.debug('■■テスト検証■■');
        // コントローラのプロパティとURLセットした取引先が同じ
        System.assertEquals(ctrl.acc.Name, newAcc.Name);
        //URLパラメータのＩｄがない
        System.assertEquals(ctrl.acc.Opportunities.size(), newOpps.size());
    }

        @isTest
        /*初期処理(異常系) */
        static void testDoInitFail() {
            System.debug('■■テスト準備■■');
            
    
            // 現在のページを作成して、URLパラメータに取引先Idをセット
            PageReference pageRef = Page.SampleProduction3Vf;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', '不正ID文字列');
    
            SampleAccountEditController ctrl = new SampleAccountEditController();
            
            System.debug('■■テスト実行■■');
            Test.startTest();
            ctrl.doinit();
            Test.stopTest();
           
    
            System.debug('■■テスト検証■■');
            // コントローラのプロパティとURLセットした取引先が同じ
            System.debug(ApexPages.getMessages());
            System.assert(ApexPages.hasMessages());
            
        }

        @isTest
        /*保存処理(正常系) */
        static void testDoSave() {
            System.debug('■■テスト準備■■');
            Account newAcc = createAccountData();
            List<Opportunity> newOpps = createOpportunityData(newAcc.id);
    
            // 現在のページを作成して、URLパラメータに取引先Idをセット
            PageReference pageRef = Page.SampleProduction3Vf;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', '不正ID文字列');
    
            SampleAccountEditController ctrl = new SampleAccountEditController();
            ctrl.doinit();

            //取引先名や金額の変更
            ctrl.acc.Name = '取引先名変更';
            ctrl.acc.Opportunities[0].amount = 2000;
            ctrl.acc.Opportunities[0].amount = 2000;

            System.debug('■■テスト実行■■');
            Test.startTest();
            PageReference goToPage = ctrl.doCustomSave();
            Test.stopTest();

            System.debug('テスト検証');
            //取引先の名前が変わった検証
            Account savedAcc = [select name from Account
                                where id =: newAcc.id
                                limit 1
                                ];

            System.assertEquals(savedAcc.Name, '取引先名変更');

            //商談の金額が一致していることの検証
            AggregateResult agr =
            [Select Sum(amount)sum_amt
             from opportunity where id in :newOpps];
            System.assertEquals((Decimal)agr.get('sum_amt'), 4000);

            //ボタンを押した後の遷移先
            System.assertEquals(goToPage.getUrl(), '/' + newAcc.id);
        }

        /*テストデータ作成用(取引先) */
        static Account createAccountData() {
            Account newAcc = new Account(Name='sample');
            insert newAcc;
            return newAcc;
        }

        @isTest
        /*保存処理(異常系) */
        static void testDoSaveFail() {
            System.debug('■■テスト準備■■');
            Account newAcc = createAccountData();
           
            // 現在のページを作成して、URLパラメータに取引先Idをセット
            PageReference pageRef = Page.SampleProduction3Vf;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', '不正ID文字列');
    
            SampleAccountEditController ctrl = new SampleAccountEditController();
            ctrl.doinit();

            //取引先名をnillにしてエラーにする
            ctrl.acc.Name = null;
           
            System.debug('■■テスト実行■■');
            Test.startTest();
            PageReference goTpPage = ctrl.doCustomSave();
            Test.stopTest();

            System.debug('■■テスト検証■■');
            // コントローラのプロパティとURLセットした取引先が同じ
            System.debug(ApexPages.hasMessages());
            System.assert(ApexPages.hasMessages());
            
           
            //ボタンを押した後の遷移先
            System.assertEquals(goToPage, null);
        }

        /*テストデータ作成用(取引先) */
        static Account createAccountData() {
            Account newAcc = new Account(Name='sample');
            insert newAcc;
            return newAcc;
        }



        /*テストデータ作成用(商談) */
        static Opportunity[] createOpportunityData(id accId) {

            List<Opportunity> newOpps = new List<Opportunity>();
            newOpps.add(new Opportunity(name = 'op1', StageName = 'Prospecting',
                                        CloseDate = Date.today(),
                                        Amount = 1000,
                                        AccountId = accId));
            newOpps.add(new Opportunity(name = 'op2', StageName = 'Prospecting',
                                        CloseDate = Date.today(),
                                        Amount = 1000,
                                        AccountId = accId));
    
            insert newOpps;
            return newOpps;
        }

}
