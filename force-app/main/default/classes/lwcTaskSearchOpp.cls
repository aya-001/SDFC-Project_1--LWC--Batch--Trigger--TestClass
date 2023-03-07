public with sharing class lwcTaskSearchOpp {
    @AuraEnabled(cacheable=true)
    public static List<Task> getTaskList(String oppId){
        Integer taskNum = 0;
        List<Task> taskList = new List<Task>();

        taskList = [SELECT Id, WhatId, Subject,  ActivityDate, Status, OwnerId, Owner.Name FROM Task
        WHERE WhatId =: oppId  ORDER BY ActivityDate ASC];
        //taskNum = taskList.size();

        
        return taskList;
    }

    
}
