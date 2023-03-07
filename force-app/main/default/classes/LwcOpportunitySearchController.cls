public with sharing class LwcOpportunitySearchController {


   @AuraEnabled(cacheable=true)
        public static List<Opportunity> oppSearchList(Opportunity getinfo){//検索ボタン押下時の動作
                String  opps = getinfo.StageName;
                String key = getinfo.Name;
                String oppkbn = getinfo.OpportunityKBN__c;
                System.debug(key);
                System.debug(oppkbn);
                System.debug(opps);
               
        String srch = '%' + key + '%' ;//検索キーワード用の変数
        String query = 'SELECT Id, Name, StageName, Amount, AccountId, Account.Name, Owner.Name,OwnerId, OpportunityKBN__c  FROM Opportunity WHERE OpportunityKBN__c = :oppkbn';
    
        
                if(opps != '') {//フェーズの指定有り
                        query +=' AND StageName =: opps'; //フェーズ。商談区分が同じ商談を取得
                }
                if(String.isNotBlank(key)){//商談名の指定有り
                        query += ' AND Name LIKE \'%' + String.escapeSingleQuotes(srch) + '%\''; //商談区分が同じ商談を取得
                }
                 //上記両方通る場合もあり
                query += ' ORDER BY Amount DESC NULLS last LIMIT 20';
                System.debug(query); 
                List<Opportunity> OppList = Database.query(query);

                System.debug('リスト' + OppList);
                return OppList;
       
        }
 
    
}
