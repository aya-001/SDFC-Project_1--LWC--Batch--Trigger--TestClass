//商談が成立した場合にアンケートを入力させる。(保存ボタン押下後、LWC画面が起動)								
//回答期日の入力があり満足度が登録されていないレコードを更新させる。(複数件表示)								
//登録中はローディング画像を表示して、ボタンがダブルクリックできないようにする。								
//登録結果をトースターとして表示させる。								

import { LightningElement, wire, track, api } from 'lwc'; //wire使用
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import SURVEY_OBJECT from '@salesforce/schema/Survey__c';
import SATISFACTION from '@salesforce/schema/Survey__c.Level__c';
import opName from '@salesforce/schema/Opportunity.Name';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';//データ登録後に結果をトースト形式で表示する
import updateSur from '@salesforce/apex/LwcQuestionaryOppController.updateSurvey';
import surveySearch from '@salesforce/apex/LwcQuestionaryOppController.surveySearchList';

export default class LdsCreateRecord extends LightningElement {
        @api recordId;//商談区分取得
        @api isLoaded = false;
        surId;//満足度Id
        deadLine;//回答期日
        comment;//コメントhtml
        oppName;
        data;
        isChangePanel = true;
        dataList;

        /* get bgImageStyle() {
                return `background-image: url(${My_Resource})`;
            } */

        @wire(getRecord, { recordId: '$recordId', fields: opName})//現在のページから商談情報取得
        wiredOpp({ error, data }) {
                if (data) {
                        this.oppName = data.fields.Name.value;//商談名を格納
                        
                } else if (error) {
                        this.error = error;
                        this.oppName= undefined;
                }
        } 
 
        @wire(surveySearch, {recordId: '$recordId'})//商談ID取得 contloeer呼び出し
               wiredSurv({error, data}) {
                const comment = '';//新規コメントの入力の有無判定
                if(data) {
                        console.log("データ11" + JSON.stringify(data));
                        this.dataList = data;
                        console.log("データリスト" + JSON.stringify(this.dataList));
                        
                } else if(error) {
                        this.deadLine = undefined;
                        this.error = error;
                } 
        }   


    
        lickedButton(){
                console.log("lwc非表示 lickedButton11");
                if (this.deadLine === undefined) {//lwc非表示、回答期日の指定あるものが０、該当なし
                        console.log("lwc非表示 lickedButton22");
                        this.isChangePanel = false;
                }
                return isChangePanel;
        }

@wire(getObjectInfo, { objectApiName: SURVEY_OBJECT })//満足度objの満足度選択リスト値取得
surveyObjectInfo;

@wire(getPicklistValues, { recordTypeId: '$surveyObjectInfo.data.defaultRecordTypeId', fieldApiName: SATISFACTION })
satisfactiobOptions;

        get _hasPicklistValues(){   //選択リストに値追加
        return [{ label: "--None--", value: "" },
        ...this.satisfactiobOptions.data.values];
}


isInputValid() {  // 各lightning-inputのvalidationチェック
        let isValid = true;
        let input = this.template.querySelectorAll('.classTest1');
        input.forEach(inputField => {
          if(!inputField.checkValidity()) {//if false
            inputField.reportValidity();
            isValid = false;
          }
        });
        return isValid;
      }
    
      validationCheck() {  // 保存押下時に呼び出し
        if(this.isInputValid()) {
          let input = this.template.querySelectorAll('.classTest1');
          input.forEach(inputField => {
            console.log('入力値：' + inputField.value);
          })
          this.RegisterSurvey();
        }
      }


RegisterSurvey() {  // 満足度調査の登録
        console.log('RegisterSurvey');
        console.log("データ" + JSON.stringify(this.dataList));
        console.log("querySelector" + this.template.querySelector('.classTest2').value);
       /*  
        this.isLoaded = !this.isLoaded;
        console.log("Spinner" + this.isLoaded); */

        const satis = '';
        this.satis = this.template.querySelector('.classTest1').value;
        this.comment = this.template.querySelector('.classTest2').value;
        this.surId = this.template.querySelector('.classTest3').value;
        console.log('444444');

        let field = {};  //オブジェクト型へ詰める
        field.Id = this.surId;//満足度Id
        field.Level__c = this.satis;//満足度の内容s
        field.Comment__c = this.comment;//コメント内容
        console.log('let field');

        console.log("満足度Id" + JSON.stringify(this.surId));
        console.log("商談名" + JSON.stringify(this.oppName));//JSON.stringifyオブジェクト型の参照
        console.log("満足度" + JSON.stringify(this.satis));
        console.log("新コメント" + JSON.stringify(this.comment));//value opps.StageName
        

        // Apexメソッドをコール [acc]はメソッドの引数名
        updateSur({ sur: field })//データ登録
                // 成功した場合
                .then(result => {
                        console.log("udateSUr後 " + JSON.stringify(result));/*console.log("ShowToastEvent");/* [' + result'] */ 
                        this.dispatchEvent(
                                new ShowToastEvent({
                                        title: '成功',
                                        message: '満足度調査が登録されました',
                                        variant: 'success',
                                }),
                        );
                })
                // 例外が発生した場合
                .catch(error => {
                        this.dispatchEvent(
                                new ShowToastEvent({
                                        title: '失敗',
                                        message: error.body.message,
                                        variant: 'error',
                                }),
                        );
                });
}
}