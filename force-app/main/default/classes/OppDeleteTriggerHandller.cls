public with sharing class OppDeleteTriggerHandller {

    public void deleteOpp(List<Opportunity> oldList, Map<Id,Opportunity> oldMap) {//商談区分チェック、削除またはTo作成
        System.debug('deleteOppチェック');
        List<Task> taskList = new List<Task>();

        taskList = [SELECT Id, WhatId FROM Task WHERE WhatId in: oldMap.keySet()];
        System.debug('ToDoサイズ' + taskList.size());

        for(Task task: taskList){
            for(Opportunity op: oldList){
                if(task.WhatId == op.Id){
                    op.addError('関連するTO Doがあるため削除できません');
                }
            }
        }

    }    
}        
                                                            

           /* 
            oppList = [SELECT Id FROM Opportunity WHERE Id in: Ids];
            System.debug('商談サイズ' +  oppList.size());

            for(Opportunity opp : oppList){
                System.debug('商談チェック11' + opp);
                    opp.addError('関連するTO Doがあるため削除できません');
                
            } */

        
        
        
 
/* 
        public void deleteOpp(Map<Id,Opportunity> oldMap) {//商談区分チェック、削除またはTo作成
            System.debug('deleteOppチェック');
            List<Task> taskList = new List<Task>();
            List<Opportunity> oppList = new List<Opportunity>();
            Set<Id> ids = new Set<Id>();
    
            taskList = [SELECT Id, WhatId FROM Task WHERE WhatId in: oldMap.keySet()];
            System.debug('ToDoサイズ' + taskList.size());
            
            for(Id oppId: oldMap.keySet()){
                for(Task task: taskList){
                    if(oppId == task.Id){
                        oldMap.addError('関連するTO Doがあるため削除できません');
                    }
                }
            }
            */
           /*  for(Task task: taskList){
            if(oldMap.keySet() == task.Id){
                oldMap.keySet().addError('関連するTO Doがあるため削除できません');
            }
            } */
                    //Ids.add(task.WhatId); 
            
            /* oppList = [SELECT Id FROM Opportunity WHERE Id in: Ids];
            System.debug('商談サイズ' +  oppList.size());

            for(Opportunity opp : oppList){
                System.debug('商談チェック11' + opp);
                //System.debug('商談チェック' +  opp.addError('関連するTO Doがあるため削除できません'));
                opp.addError('関連するTO Doがあるため削除できません');
                
            } */
        
