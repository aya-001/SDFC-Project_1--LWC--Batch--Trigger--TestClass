
public class ContactSummeryBatch implements Database.Batchable<sObject>{
    //selectで取引先責任者数（取引先に紐づく）をカウント

    public Database.QueryLocator start(Database.BatchableContext bc) {//データ取得
       String query = 'SELECT Id,AccountId,Name FROM Contact WHERE AccountId != NULL';
       return Database.getQueryLocator(query);
   }

   
   public void execute(Database.BatchableContext BC, List<Contact> newList) { //バッチ処理//取引先責任者数（取引先に紐づく）をカウントするメソッド
        Map<Id, Account> accountToUpdate = new Map<Id, Account>();   
        System.debug('accountCountチェック');
       
       for(Contact c : newList) { //取得したリスト情報を回す
           Account a = new Account(Id = c.AccountId,ContactNum__c = 0);//取引先Id,責任者数を詰める
           accountToUpdate.put(c.AccountId, a);
       }

       
       //取引先責任者の数を集計
       List<AggregateResult> results = 
       [SELECT  AccountId, COUNT(Id) co  FROM Contact WHERE Account.Id in : accountToUpdate.keySet() GROUP BY AccountId]; 

       for(AggregateResult rslt: results) { //取引先責任者(Contact)の配列を回す、Id、集計地を取得
           Id accId = (Id)rslt.get('AccountId');
           Account aa = new Account(Id = accId,ContactNum__c = (Integer)rslt.get('co'));
           System.debug( 'Aggregate Test');

           accountToUpdate.put(accId,aa);
       } 

       System.debug(accountToUpdate + '更新');

       //system.debug('Batchスケジューラークラス');
       try{                                 //mapをリスト型へ変換
           update accountToUpdate.values(); //List＜Account＞＝List＜Id,Account＞
       }catch(ListException e) {
           System.debug(e.getMessage());
       }

     
   }

   

 //終了後処理
   public void finish(Database.BatchableContext bc){
       System.debug('終了Completed');  
   }

}
   
   
