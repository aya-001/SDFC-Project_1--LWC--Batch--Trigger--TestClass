import { LightningElement, wire, api } from 'lwc';
import getTaskList from '@salesforce/apex/lwcTaskSearchOpp.getTaskList';
const columns = [
    { label: '件名', fieldName: 'Subject' },
    { label: '期日', fieldName: 'ActivityDate' },
    { label: '状況', fieldName: 'Status' },
    { label: '割り当て先', fieldName: 'Owner.Name' },
];
export default class LwcTaskSearchOpp extends LightningElement {
    @api recordId;
    columns = columns;
    records;
    num = 0;//To Doの数


    @wire(getTaskList, { oppId: '$recordId' })
    wiredOpps({ error, data }) {
        if (data) {
            this.records = data.map(data => this.convertRecord(data));//商談Id,所有者名をIdから名前に変換;
            console.log("検索結果22" + JSON.stringify(this.records));
            this.num = data.length;
            console.log("検索結果22" + JSON.stringify(data));
        }
    }

    convertRecord(obj, newObj = {}, aboveKey = "") { //Object.keys() は、要素が object に直接ある列挙可能なプロパティに対応する文字列である配列を返す
        Object.keys(obj).forEach(key => {  //Object.keys() メソッド.オブジェクトが持つプロパティの 名前の配列を、通常のループで取得するのと同じ順序で返す
            const value = obj[key];    //値を変数へ代入,「キー」と「値」のペアで保持
            const currentKey = aboveKey + key;//' key'
            if (typeof value === 'object' && !Array.isArray(value)) {//型をチェック,Array.isArray() メソッドは、渡された値が Array(配列) かどうかを判断
                this.convertRecord(value, newObj, currentKey + '.');
            } else {
                newObj[currentKey] = value;
            }
        });
        return newObj;
    }
}

