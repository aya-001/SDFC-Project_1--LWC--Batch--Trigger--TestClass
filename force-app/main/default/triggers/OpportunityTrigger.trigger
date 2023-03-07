trigger OpportunityTrigger on Opportunity (after insert, after update, before delete) {

    //OpportunityTriggerHandller handler = new OpportunityTriggerHandller();
    //ToDoMakeTriggerHandller handlers = new ToDoMakeTriggerHandller();//インスタンス
    //OppDeleteTriggerHandller deleteHandler = new OppDeleteTriggerHandller();
    //相反するためコメントアウトしています
    
    if(Trigger.isAfter && Trigger.isInsert|| Trigger.isAfter && Trigger.isUpdate) {
        
    }
    //if(Trigger.isAfter && Trigger.isInsert) {
        //handler.input(Trigger.new);  //OpportunityTriggerHandllerのメソッド呼び出し
        //handlers.inputToDo(Trigger.new); 
    //}else if(Trigger.isAfter && Trigger.isUpdate) {
        //handler.checkNewKbn1(Trigger.old);  //OpportunityTriggerHandllerのメソッド呼び出し
        //handlers.checkNewKbn(Trigger.new, Trigger.oldMap);  
    //}else */ 
    //if(Trigger.isBefore && Trigger.isDelete){
        //deleteHandler.deleteOpp(Trigger.old, Trigger.oldMap);
        //Trigger.old[0].addError('関連するがあるため削除できません');
        
    }
