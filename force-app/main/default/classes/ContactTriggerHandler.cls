public class ContactTriggerHandler {
    //selectで取引先責任者数（取引先に紐づく）をカウント


   public void accountCount(List<Contact> newList) { //取引先責任者数（取引先に紐づく）をカウントするメソッド
       System.debug('accountCountチェック');
           //mapにIdとAccount情報を格納
       Map<Id, Account> accountToUpdate = new Map<Id, Account>();
       
       for(Contact c : newList) { //Trigger.newから取得したリスト情報を回す
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

       try{                                 //mapをリスト型へ変換
           update accountToUpdate.values(); //LiList＜Account＞＝LiList＜Id,Accouny＞
       }catch(ListException e) {
           System.debug(e.getMessage());
       }

   }


   public void accountError(List<Contact> errorNewList) { //エラー時のメソッド
       for(Contact c2 : errorNewList) {
           if(c2.AccountId == NULL){
               c2.addError('取引先を入力してください');
           }
       }

   }

}
   
   