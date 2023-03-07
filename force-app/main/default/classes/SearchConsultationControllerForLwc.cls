public with sharing class SearchConsultationControllerForLwc {
    @AuraEnabled(Cacheable=true)
    /* public static List<Opportunity> getSearchConsultation(Opportunity params){
        System.debug('params.OwnerId：' + params.OwnerId);

        //取得したIDから商談区分を取得
        Opportunity opp = [SELECT OwnerId, DiseaseName__c FROM Opportunity WHERE OwnerId =: params.OwnerId];
        String getDisease = opp.DiseaseName__c;
        Id getOwnerId = opp.OwnerId;

        System.debug('getDisease：' + getDisease);

        String setSoql = 'SELECT Name, DiseaseName__c, CloseDate FROM Opportunity WHERE OwnerId =: getOwnerId';
        
        //フェーズが選択されたとき
        if(!String.isBlank(params.DiseaseName__c)){
            setSoql += ' AND DiseaseName__c =: getDisease';
        }

        List<Opportunity> searchOpps = Database.query(setSoql);
        return searchOpps;
    } */

    public static List<Opportunity> getSearchConsultation(String userId,  String Diagnosis){
        System.debug('動いた');
        System.debug('userIdだす' + userId);
        
        //System.debug('0055g00000F28s2 ユーザID'+ userId);
        //String setSoql = 'SELECT Name, DiseaseName__c, CloseDate FROM Opportunity WHERE OwnerId =: getOwnerId';

        String getUserId = userId.left(15);
        System.debug('UserId２２' + getUserId);

        List<Opportunity> oppList = new List<Opportunity>();
        oppList = [SELECT DoctorForCoading__c, BookingNumber__c,DiseaseName__c, CloseDate FROM Opportunity WHERE DoctorForCoading__c =: getUserId AND DiseaseName__c =: Diagnosis];

        System.debug('oppList中身' + oppList);

        return oppList;
    }

}
