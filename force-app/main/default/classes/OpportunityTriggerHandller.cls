public with sharing class OpportunityTriggerHandller {
//商談レコードの新規作成時に、商談の[所有者]に新規ToDoを登録する
//新規に作成するToDoは[件名]が"契約書送付"、[期日]が商談の[完了日の]7日前、[関連先]は元となった商談レコードと関連させる
//ハンドラ―クラスを作成する（ロジッククラスは作成しないでも良いものとする）
//例外処理を正しく行うこと
//作成したコードに対するテストクラスを作成すること
 
    public void input(List<Opportunity> newList) { //商談、ToDo新規作成用メソッド
        System.debug('inputチェック');

        List<Task> taskList = new List<Task>();  //ToDo用の配列
        for(Opportunity opp: newList) {         //新規作成triggerの数分、ループ
            Task input = new Task(Subject = '契約書送付', ActivityDate = opp.CloseDate - 7, WhatId = opp.id);
            taskList.add(input);
        }
        System.debug(taskList + '更新');

        try{
            insert taskList;
        }catch(ListException e) {
            System.debug(e.getMessage());
        }
    }
}

/* Opportunity oops = new Opportunity();
        List<Task> taskList = new List<Task>();
        for(Task tsk: taskList) {
        taskList.add(new Task(Subject = '契約書送付', ActivityDate = oops.CloseDate - 7, WhatId = oops.id));    
        }
        */ 

/* public void validationCheck(List<Opportunity> newList) { //before insert
    System.debug('validationCheck');

    for(Opportunity opp: newList){
        if(CloseDate-7 < today()){
            opp.addError('完了日が近いため登録できません');
        }
    }
} */
