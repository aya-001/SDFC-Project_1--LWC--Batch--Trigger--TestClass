@isTest
private class OpportunitySearchControllerTest {

    @isTest
    static void myUnitTest1() { //Controllerのテスト
        System.debug('■■テスト準備■■');
       
        Opportunity op1 = new Opportunity(Name = 'op1', StageName = 'Prospecting',
                                          CloseDate = Date.today(),Amount = 1000, OpportunityKBN__c = 'salesforce導入支援');
        insert op1;
        //ApexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ
        List<Opportunity> newOpps = new List<Opportunity>();
            newOpps.add(new Opportunity(name = 'op1', StageName = 'Prospecting',
                                        CloseDate = Date.today(),
                                        Amount = 1000,
                                        OpportunityKBN__c = 'salesforce導入支援'/* ,
                                        AccountId = id.AccountId */));

           // 現在のページを作成して、URLパラメータに取ApexPage.currentPage().getParameters().put();引先Idをセット
        PageReference pageRef = Page.OpportunitySearch; //VF pageVF pageの読み込み
        Test.setCurrentPage(pageRef);  //ぺページの指定
        //ApexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ

        ApexPages.StandardController sc = new ApexPages.StandardController(op1);// StandardControllerのもとになるオブジェクト（opportunity）をセット
        
        System.debug('■■テスト実行■■');
        Test.startTest();
        OpportunitySearchController ctrl = new OpportunitySearchController(sc);//// 拡張コントローラはコンストラクタにStandardControllerを渡す
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.assertEquals(ctrl.KeyNone, '0');//商談区分名一致
    }

    @isTest  //正常系(getOppStageName())
    static void myUnitTest2() { 
        System.debug('■■テスト準備■■');
        Opportunity op1 = new Opportunity(Name = 'op1', StageName = 'Prospecting',
                                          CloseDate = Date.today(),Amount = 1000, OpportunityKBN__c = 'salesforce導入支援');
        insert op1;
        //pexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ                                            

           // 現在のページを作成して、URLパラメータに取ApexPage.currentPage().getParameters().put();引先Idをセット
        PageReference pageRef = Page.OpportunitySearch; //VF pageVF pageの読み込み
        Test.setCurrentPage(pageRef);  //ぺページの指定
        //ApexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ

        ApexPages.StandardController sc = new ApexPages.StandardController(op1);// StandardControllerのもとになるオブジェクト（opportunity）をセット
        OpportunitySearchController ctrl = new OpportunitySearchController(sc);//// 拡張コントローラはコンストラクタにStandardControllerを渡す
        
        System.debug('■■テスト実行■■');
        Test.startTest();
        ctrl.getOppStageName();//商談名を入力するメソッド
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.assertEquals(ctrl.oppStageName.size(), 11);//商談フェーズの数が一致
    }

    @isTest  //正常系(searchListOpp())
    static void myUnitTest3() { 
        System.debug('■■テスト準備■■');
        
        Opportunity op1 = new Opportunity(Name = 'op0', StageName = 'Prospecting',
                                          CloseDate = Date.today(),Amount = 1000, OpportunityKBN__c = 'salesforce導入支援');
        insert op1;

        ApexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ                                            
        List<Opportunity> newOpps = new List<Opportunity>();
            newOpps.add(new Opportunity(Name = 'op1', StageName = 'Prospecting',
                                        CloseDate = Date.today(),
                                        Amount = 1000,
                                        OwnerId = '0055i000006BQ5PAAW',
                                        OpportunityKBN__c = 'salesforce導入支援' ,
                                        AccountId = '0015i00000OGtHxAAL'));
            newOpps.add(new Opportunity(Name = 'op2', StageName = 'Prospecting',
                                        CloseDate = Date.today(),
                                        Amount = 1000,
                                        OwnerId = '0055i000006BQ5PAAW',
                                        OpportunityKBN__c = 'salesforce導入支援' ,
                                        AccountId = '0015i00000OGtHxAAL'));
    
            insert newOpps; 
            System.debug('商談insert' + newOpps);
           // 現在のページを作成して、URLパラメータに取ApexPage.currentPage().getParameters().put();引先Idをセット
        PageReference pageRef = Page.OpportunitySearch; //VF pageVF pageの読み込み
        Test.setCurrentPage(pageRef);  //ぺページの指定
        //ApexPages.currentPage().getParameters().put('id', op1.id); //商談のＩＤ

        ApexPages.StandardController sc = new ApexPages.StandardController(op1);// StandardControllerのもとになるオブジェクト（opportunity）をセット
        OpportunitySearchController ctrl = new OpportunitySearchController(sc);//// 拡張コントローラはコンストラクタにStandardControllerを渡す
        
        ctrl.oppStage = '0';
        ctrl.srchKeyword = '';
        System.debug('■■テスト実行■■');
        Test.startTest();
        ctrl.searchListOpp();//ボタンをクリックして検索
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.debug('テスト区分１' + ctrl.oppvalue.OpportunityKBN__c);
        System.debug('テスト区分2' + ctrl.getDetails.get(0).OpportunityKBN__c);
        System.assertEquals(ctrl.oppvalue.OpportunityKBN__c, ctrl.getDetails.get(0).OpportunityKBN__c);//商談区分名一致
    }

/* 
    @isTest
    static void myUnitTestFauil() {   //異常系
        System.debug('■■テスト準備■■');
        //Account acc = new Account(name = 'sample');
        //insert acc;
        //static Opportunity[] createOpportunityData(id accId) 
        /* Opportunity op1 = new Opportunity(name = 'op0', StageName = 'Prospecting',
                                                    CloseDate = Date.today(),Amount = 1000, OpportunityKBN__c = 'salesforce導入支援');
        insert op1; */
        /*Opportunity op1 = null;
        insert op1;
        
           // 現在のページを作成して、URLパラメータに取ApexPage.currentPage().getParameters().put();引先Idをセット
        PageReference pageRef = Page.OpportunitySearch; //VF pageVF pageの読み込み
        Test.setCurrentPage(pageRef);  //ぺページの指定
        ApexPages.currentPage().getParameters().put('id', '不正なID文字列'); //取引先のＩＤ

        ApexPages.StandardController sc = new ApexPages.StandardController(op1);// StandardControllerのもとになるオブジェクト（opportunity）をセット
        OpportunitySearchController ctrl = new OpportunitySearchController(sc);//// 拡張コントローラはコンストラクタにStandardControllerを渡す
        
        System.debug('■■テスト実行■■');
        Test.startTest();
        ctrl.searchListOpp();//ボタンをクリックして検索
        Test.stopTest();

        System.debug('■■テスト検証■■');
        System.debug(ApexPages.getMessages());
        System.assert(ApexPages.hasMessages()); //エラーメッセージ出る
    }  */

   
}
