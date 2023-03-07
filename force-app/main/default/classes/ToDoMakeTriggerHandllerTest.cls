@isTest
public with sharing class ToDoMakeTriggerHandllerTest {
//商談1件、複数件で数があっているか
    @isTest
    static void unitTest1() {
        System.debug('unitTest1テスト準備');
        Date myDate = Date.newinstance(2022, 9, 11); //日付用の変数→商談データ作成
        Opportunity opp = new Opportunity(Name = 'SampleA', CloseDate = myDate, StageName = 'Prospecting', OpportunityKBN__c = 'コンサルティング');

        System.debug('テスト実行');
        Test.startTest();
        insert opp;//商談データ作成
        Test.stopTest();

        System.debug('テスト検証');     //中身を確認する
        //System.assert(results.get(0).isSuccess());

        List<Task> madeTask = new List<Task> ();
        madeTask = [SELECT id, WhatId FROM Task WHERE WhatId =: opp.id ];
        System.debug(madeTask.size() + 'リストチェック');
        system.assertEquals(madeTask.size(),3);//To　DOが３つ

    }

    @isTest
        static void bulkTest() {//大量データ
            System.debug('unitTest1テスト準備');
            Date myDate = Date.newinstance(2022, 9, 11); //日付用の変数
            List<Opportunity> newOppsList = new List<Opportunity>(); //商談データ格納用の配列
            for(integer i = 0; i < 3; i++) {
                newOppsList.add(new Opportunity(Name = 'sample'+i, CloseDate = myDate, StageName = 'prospecting', OpportunityKBN__c = 'コンサルティング'));
            }

            System.debug('テスト実行');//レコード作成
            Test.startTest();
            List<Database.SaveResult> bulkResultsList = Database.insert(newOppsList, false); //商談のデータ入力、インサートの記録確認
            Test.stopTest();

            System.debug('テスト検証'); 
            AggregateResult agr = [SELECT COUNT(Id)coo FROM Task WHERE Subject =: '訪問予定'];
            //System.debug('データの数' + bulkResultsList.size());
            System.debug('データの数' + agr.get('coo'));
            System.assertEquals((Decimal)agr.get('coo'), 3);

           
        }
        //削除時
        @isTest
        static void deleteTest1() {//商談update
        System.debug('deleteTest1テスト準備');
        Date myDate = Date.newinstance(2022, 9, 28); //日付用の変数→商談データ作成
        Opportunity opp1 = new Opportunity(Name = 'Sample1', CloseDate = myDate, StageName = 'Prospecting', OpportunityKBN__c = 'コンサルティング');
        insert opp1;
        
        //Opportunity oldopp = [SELECT Id, OpportunityKBN__c, Name FROM Opportunity WHERE Name =: 'Sample1'];
        opp1.OpportunityKBN__c = 'その他'; //値を上書き

        System.debug('テスト実行');
        Test.startTest();
        update opp1;//商談データUpdate
        System.debug(opp1);
        //List<Database.SaveResult> results = Database.insert(oppList, false); //商談のデータ入力、インサートの記録確認
        Test.stopTest();

        System.debug('テスト検証');     //中身を確認する
        List<Task> deleteTask = new List<Task>();
        deleteTask = [SELECT id FROM Task WHERE WhatId =: opp1.Id ];
        System.debug(deleteTask);
        System.debug(deleteTask + 'リストチェック');
        system.assertEquals(deleteTask.isEmpty(), true);//To　DO削除される

    }
}
