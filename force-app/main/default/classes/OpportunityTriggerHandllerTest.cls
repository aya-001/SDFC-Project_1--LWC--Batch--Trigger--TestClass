
@isTest
public with sharing class OpportunityTriggerHandllerTest {
//商談1件、複数件で数があっているか
    @isTest
    static void unitTest1() {
        System.debug('unitTest1テスト準備');
        Date myDate = Date.newinstance(2022, 8, 30); //日付用の変数
        Opportunity opp = new Opportunity(Name = 'sample', CloseDate = myDate, StageName = 'Prospecting');

        System.debug('テスト実行');
        Test.startTest();
        insert opp;
        //List<Database.SaveResult> results = Database.insert(oppList, false); //商談のデータ入力、インサートの記録確認
        Test.stopTest();

        System.debug('テスト検証');     //中身を確認する
        //System.assert(results.get(0).isSuccess());

        List<Task> afterSaveTask = new List<Task> ();
        afterSaveTask = [SELECT id,ActivityDate FROM Task WHERE WhatId =: opp.id ];
        System.debug(afterSaveTask + 'リストチェック');
        system.assertEquals(Date.newinstance(2022, 8, 23), afterSaveTask.get(0).ActivityDate);

    }

    @isTest
        static void bulkTest() {
            System.debug('unitTest1テスト準備');
            Date myDate = Date.newinstance(2022, 9, 11); //日付用の変数
            List<Opportunity> newOppsList = new List<Opportunity>(); //商談データ格納用の配列
            for(integer i = 0; i < 201; i++) {
                newOppsList.add(new Opportunity(Name = 'sample'+i, CloseDate = myDate, StageName = 'prospecting'));
            }

            System.debug('テスト実行');
            Test.startTest();
            List<Database.SaveResult> bulkResultsList = Database.insert(newOppsList, false); //商談のデータ入力、インサートの記録確認
            Test.stopTest();

            System.debug('テスト検証'); 
            System.debug('データの数' + bulkResultsList.size());

            //isSuccess, 
            //assertEquals 201 =
            //todo 全権取ってくる　リストサイズ２０１
           
        }
}
