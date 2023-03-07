public with sharing class OpportunitySearchController {

    //public Opportunity oops{get; set;}
    public Opportunity opps;
    public Opportunity oppvalue ;/* {get; set;} */
    //public Opportunity currentResults {get; set;}//レコード情報取得、更新
    public list<selectoption> oppStageName { get; set; } //商談フェーズ取得、更新
    public String oppStage{get; set;}   //選択したフェーズ取得
    public List<Opportunity> getDetails{get; set;}
    public String srchKeyword{get; set;}  //検索用語をvisualforeから取得、情報更新
    public String KeyNone = '0'; //フェーズ選択リストの選択なし

   
    public OpportunitySearchController(ApexPages.StandardController stdController){  //商談区分取得
        this.opps = (Opportunity)stdController.getRecord();
        System.debug(opps);
        this.oppvalue = [SELECT OpportunityKBN__c FROM Opportunity WHERE id =: this.opps.Id]; //商談区分取得,ページが表示された時に1度取得

    }

    public list<selectoption> getOppStageName(){//商談フェーズを取得
        oppStageName = new list<selectoption>();
		Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();//Field Describe Result オブジェクトをインスタンス化,sObject 項目を記述するメソッド
		List<Schema.PicklistEntry> pickValues = fieldResult.getPicklistValues();//選択リスト内のこの項目の値を返す
        oppStageName.add(new SelectOption('0','--None--'));//フェーズ選択なし
        for( Schema.PicklistEntry p : pickValues)
		{   
			oppStageName.add(new SelectOption(p.getLabel(), p.getValue()));//選択リスト内のこの項目の表示名,選択リスト内のこの項目の値を返す
		}   
        return oppStageName;
    }

    public PageReference searchListOpp(){ //検索ボタンが押された後のメソッド,検索
        System.debug('確認searchListOpp');

        //Opportunity oppvalue = [SELECT OpportunityKBN__c FROM Opportunity WHERE id =: this.opps.Id]; //商談区分取得
        String oppValue1 = this.oppvalue.OpportunityKBN__c;
        String srch = '%' + srchKeyword + '%';  //検索キーワード用の変数
        String query = 'SELECT Id, Name, StageName, Amount, AccountId, OwnerId, OpportunityKBN__c FROM Opportunity WHERE OpportunityKBN__c = :oppValue1';

         try{ 

        if(oppStage != KeyNone) {
            query +=' AND StageName =:oppStage'; //フェーズ。商談区分が同じ商談を取得
        }
        if(String.isNotBlank(srchKeyword)) {
            query += ' AND Name LIKE \'%' + String.escapeSingleQuotes(srch) + '%\''; //商談区分が同じ商談を取得
        }  
        //上記両方通る場合もあり
        query += ' ORDER BY Amount DESC NULLS last LIMIT 20';
        System.debug(query); 

        getDetails = Database.query(query);
     

        }catch(Exception e){
            ApexPages.addMessages(e);
        }   
        return null;
    }
    

}
