

import { LightningElement, wire, api } from 'lwc';
import getOppList from '@salesforce/apex/TableViewController.getAccountList';

const columns = [
        { label: '商談名', fieldName: 'Name' },
        { label: 'フェーズ', fieldName: 'StageName' },
        { label: '完了予定日', fieldName: 'CloseDate', type: 'date' },
        { label: '金額', fieldName: 'Amount', type: 'currency' },
];

export default class ensyuWebCompo extends LightningElement {

        columns = columns;
        records;
        @api recordId;

        @wire(getOppList, {accountid: '$recordId'})
        wiredAccounts({error, data}){
                if(data){
                        this.records = data;
                } 
        }

}
