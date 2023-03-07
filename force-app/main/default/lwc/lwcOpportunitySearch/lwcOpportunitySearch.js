import { LightningElement, wire, track, api } from 'lwc'; //wire使用
//Controllerのメソッド利用
//Lightning Web コンポーネント利用のためにApexクラスとメソッドをimport
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import ACCOUNT_NAME from '@salesforce/schema/Opportunity.Account.Name';
import OPP_OWNER from '@salesforce/schema/Opportunity.OwnerId';
import STAGE_NAME from '@salesforce/schema/Opportunity.StageName';
import oppSearchList from '@salesforce/apex/LwcOpportunitySearchController.oppSearchList';

let FIELD = ['Opportunity.OpportunityKBN__c', OPP_OWNER , ACCOUNT_NAME];//商談区分取得

const columns = [//html表示用
        { label: '商談名', fieldName: 'Name' },
        { label: 'フェーズ', fieldName: 'StageName' },
        { label: '金額', fieldName: 'Amount', type: 'currency' },
        { label: '取引先名', fieldName: 'AccountId' },
        { label: '所有者名', fieldName: 'OwnerId' },
        { label: '商談区分', fieldName: 'OpportunityKBN__c' }
]; 


export default class OppTable extends LightningElement {
    
        @api recordId;//商談区分取得
        @track value;
        @track error;
        accName;//取引先名
        oppOwner;//所有者名
        oppkbn;//商談区分
        @wire(getRecord, {recordId: '$recordId', fields: FIELD})//現在のページから情報取得
        wiredOpp({error, data}) {
                if(data) {
                        //this.record = data;
                        this.oppkbn = data.fields.OpportunityKBN__c.value;//商談区分を格納
                        this.error = undefined;
                } else if(error) {
                        this.error = error;
                        this.oppkbn= undefined;
                        this.record = undefined;
                }
        }
        @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })//フェーズの値取得
        opportunityObjectInfo;

        @wire(getPicklistValues, { recordTypeId: '$opportunityObjectInfo.data.defaultRecordTypeId', fieldApiName: STAGE_NAME })
        stageNameOptions;

        get _hasPicklistValues(){   //選択リストに値追加
                return [ {label:"--None--", value:""},
                        ...this.stageNameOptions.data.values];
        } 

        columns = columns; //HTML１HTMLからアクセスする用
        @track opportunities
        
      /*   connectedCallback(){  //初期化処理
                this.handleSearch();
        }
 */

        handleSearch(){ //検索ボタン押す
                const opps = '';
                this.opps = this.template.querySelector('.classTest1').value;
                const key = '';
                this.key = this.template.querySelector('.classTest2').value;
                
                let fields = {};  //オブジェクト型へ詰める
                fields.StageName = this.opps;
                fields.Name = this.key;
                fields.OpportunityKBN__c = this.oppkbn;
                
                
                 
                console.log("商談区分" + JSON.stringify(this.oppkbn));//JSON.stringifyオブジェクト型の参照
                console.log("検索キー" + JSON.stringify(this.key));
                console.log("フェーズ" + JSON.stringify(this.opps));//value opps.StageName
                console.log("Field２２" + JSON.stringify(fields));
               

                oppSearchList({getinfo: fields})//Controllerのメソッド呼び出し
                .then(result => {
                        console.log("検索結果" +  JSON.stringify(result));
                        this.opportunities = result.map(result => this.convertRecord(result));//商談Id,所有者名をIdから名前に変換

                        console.log("検索結果22" +  JSON.stringify(this.opportunities));
                        
                })
                .catch(error => {
                        this.opportunities = null;
                        console.log(e.body.message);
                });
        }

        convertRecord(obj, newObj = {}, aboveKey = ""){//Object.keys() は、要素が object に直接ある列挙可能なプロパティに対応する文字列である配列を返す
                Object.keys(obj).forEach(key => {  //Object.keys() メソッド.オブジェクトが持つプロパティの 名前の配列を、通常のループで取得するのと同じ順序で返す
                    const value = obj[key];    //値を変数へ代入,「キー」と「値」のペアで保持
                    const currentKey = aboveKey + key;//' key'
                    if(typeof value === 'object' && !Array.isArray(value)){//型をチェック,Array.isArray() メソッドは、渡された値が Array(配列) かどうかを判断
                        this.convertRecord(value, newObj, currentKey + '.');
                    }else{
                        newObj[currentKey] = value;
                    }
                });
                return newObj;
            }

}



