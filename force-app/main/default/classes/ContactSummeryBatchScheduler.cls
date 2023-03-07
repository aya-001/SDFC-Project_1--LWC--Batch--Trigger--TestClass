public class ContactSummeryBatchScheduler implements Schedulable{
    public void execute(SchedulableContext sc) {
        ContactSummeryBatch csb = new ContactSummeryBatch(); 
        Database.executeBatch(csb, 200);
        
    }

   
}
