public with sharing class LwcQuestionaryOppController {

        @AuraEnabled(cacheable=true)
        public static /* Survey__c */List<Survey__c> surveySearchList(Id recordId){//商談保存ボタン押下時の動作
                System.debug('動いた');

                List<Survey__c> SurList = new List<Survey__c>(); //満足度の項目取得（満足度が空欄、回答期日あり、商談と紐づく）
                /* Survey__c */ SurList = [SELECT Id , Opportunity__c ,Level__c , Deadline__c, Comment__c /* ,Opportunity__r.Name */  FROM Survey__c 
                          WHERE Opportunity__c =: recordId  AND Level__c = '' AND  Deadline__c != NULL /* LIMIT 1 */];   

                System.debug('リスト' + SurList);
                return SurList;
       
        }

        @AuraEnabled
        public static Survey__c updateSurvey(Survey__c sur){//データ登録
                System.debug('リスト1'+ sur );

                update sur;
                System.debug('リスト2' );
                return sur;
                
        }
}