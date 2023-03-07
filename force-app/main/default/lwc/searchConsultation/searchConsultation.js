import { LightningElement, wire, track, api } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getRecord} from 'lightning/uiRecordApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import OPPORTUNITY_DiseaseName from '@salesforce/schema/Opportunity.DiseaseName__c';
import getSearchConsultation from '@salesforce/apex/SearchConsultationControllerForLwc.getSearchConsultation';

//データテーブル用
const columns = [
    { label: '診察番号', fieldName: 'BookingNumber__c'},
    { label: '診断病名', fieldName: 'DiseaseName__c'},
    { label: '診察日', fieldName: 'CloseDate', type:'date'},
];

let FIELD = ['User.Id'];//ユーザobjからユーザID取得

export default class SearchOpprotunityControllerForLwc extends LightningElement {

    @api recordId;//医師のId
    usId;
    //str = this.recordId;
    //resultId = this.str.substr(0,15);//ユーザID

    @wire(getRecord, {recordId: '$recordId', fields: FIELD})//現在のページから情報取得
    wiredOpp({error, data}) {
            if(data) {
                    this.usId = data.fields.Id.value;
                    
            } else if(error) {
                    this.record = undefined;
            }
    }

    //選択リストを商談から引っ張る　ここから
    @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
    opportunityObjectInfo;

    @wire(getPicklistValues, { recordTypeId: '$opportunityObjectInfo.data.defaultRecordTypeId', fieldApiName: OPPORTUNITY_DiseaseName })
    DiseaseNameOptions;

    get _DiseaseNameOptions() {
        return [
            { label: "すべて", value: "" },
            ...this.DiseaseNameOptions.data.values
        ]; 

    }

    //ここまで

    //データベースhtml用
    @track columns = columns;

    @track data ;

    diagnosis;//診断結果選択
    

    
    handleChange(event){//診断名で検索
        console.log('Registerdiagnosis');
        this.diagnosis = this.template.querySelector('.classTest1').value;
        //let field = {};  //オブジェクト型へ詰める
        console.log("diagnosis value" +  JSON.stringify(this.diagnosis));
        console.log("recordId ページの情報" +  JSON.stringify(this.recordId));
        console.log("this.usId ページの情報" +  JSON.stringify(this.usId));
        
        


        getSearchConsultation({userId: this.usId ,  Diagnosis: this.diagnosis})
        .then(result => {
            console.log("診断通る" );
            this.data = result;
            console.log("診断結果" +  JSON.stringify(this.data));
    })
    .catch(error => {
            this.data = null;
            console.log(e.body.message);
    });

    }



    
}


