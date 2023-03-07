trigger ContactTrigger on Contact (before insert, after insert, after delete) {
//Contact新規作成時

ContactTriggerHandler handler = new ContactTriggerHandler();//インスタンス

	if(Trigger.isBefore && Trigger.isInsert ) {	 //取引先名がブランク
		handler.accountError(Trigger.new); 
	} else if(Trigger.isAfter && Trigger.isInsert ) {
		handler.accountCount(Trigger.new);  //ContactTriggerHandllerのメソッド呼び出し
	}else if(Trigger.isAfter && Trigger.isDelete) {
		handler.accountCount(Trigger.old);  //ContactTriggerHandllerのメソッド呼び出し
     }

}
