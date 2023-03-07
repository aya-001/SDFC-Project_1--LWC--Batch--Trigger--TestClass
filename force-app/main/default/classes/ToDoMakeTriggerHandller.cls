public with sharing class ToDoMakeTriggerHandller {
    //商談が登録されたとき「商談区分」がコンサルティングの場合は３ステップのTodoを自動登録する。
//「商談区分」がコンサルティングでなくなった場合に、登録していた３ステップの活動のうち、状態が完了でないものは削除する。

    public void inputToDo(List<Opportunity> checkKBNList) { //商談、ToDo新規作成用メソッド
        System.debug('inputToDoチェック');
        String kbn = 'コンサルティング';
        Set<Id> recordId = new Set<Id>();

        for(Opportunity checkopp : checkKBNList) {//商談区分がコンサルティングの時
            if(checkopp.OpportunityKBN__c == kbn){
                recordId.add(checkopp.id);
            }
        }
        if(recordId.size() != 0){//0でないとき
        asynInputToDo(recordId);
        }
    }

    

    @future(callout=true)  
    public static void asynInputToDo(Set<Id> recordIds) {
        List<Task> taskList1 = new List<Task>();
        Date Today = Date.today();
        for(Id Ids : recordIds) {
        Task input1 = new Task(Subject = System.Label.ToDoName1, 
                                        ActivityDate = Today + 3, 
                                        WhatId = Ids, 
                                        OwnerId = UserInfo.getUserId() );
                Task input2 = new Task(Subject = System.Label.ToDoName2, 
                                        ActivityDate = Today + 5, 
                                        WhatId = Ids, 
                                        OwnerId = UserInfo.getUserId());
                Task input3 = new Task(Subject = System.Label.ToDoName3, 
                                        ActivityDate = Today + 10, 
                                        WhatId = Ids, 
                                        OwnerId = UserInfo.getUserId());
                taskList1.add(input1);//タスク作成
                taskList1.add(input2);
                taskList1.add(input3);
        }

                System.debug(taskList1 + '新規');

        try{
            insert taskList1;
            
        }catch(ListException e) {
            System.debug(e.getMessage());
        }
        
    }


        // && oldMap.get(newOpp.Id).OpportunityKBN__c = kbn
        
        String kbn = 'コンサルティング';
        public void checkNewKbn(List<Opportunity> updateList, Map<Id,Opportunity> oldMap) {//商談区分チェック、削除またはTo作成
            System.debug('checkNewKbnチェック');
            List<Task> deletetaskList = new List<Task>();
            List<Opportunity> updatetaskList = new List<Opportunity>();
            Set<Id> ids = new Set<Id>();
            //List<Opportunity>KBNs = new List<Opportunity>();
            for (Opportunity newOpp: updateList) {
                if(newOpp.OpportunityKBN__c != kbn && oldMap.get(newOpp.Id).OpportunityKBN__c == kbn){
                    ids.add(newOpp.Id);
                //KBNs.add(newOpp.OpportunityKBN__c);
                } /* else if(newOpp.OpportunityKBN__c == kbn && oldMap.get(newOpp.Id).OpportunityKBN__c != kbn){
                    updatetaskList = [SELECT Id, OpportunityKBN__c, OwnerId FROM Opportunity WHERE Id =: newOpp.Id];
                    inputToDo(updatetaskList);
                }   */
            }
            deletetaskList = [SELECT Id, WhatId, Status,Subject
                                  FROM Task WHERE WhatId in: ids AND Status !=: 'Completed' 
                                  AND (Subject =: System.Label.ToDoName1 OR Subject =: System.Label.ToDoName2 OR Subject =: System.Label.ToDoName3)];

            delete deletetaskList;
        }    

}

