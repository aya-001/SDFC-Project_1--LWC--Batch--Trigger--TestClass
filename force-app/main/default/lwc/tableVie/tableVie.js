import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/TableViewController.getAccountList';

const columns = [
        { label: '会社名', fieldName: 'Name' },
        { label: 'Website', fieldName: 'Website', type: 'url' },
        { label: '電話', fieldName: 'Phone', type: 'phone' },
        { label: '最終更新日', fieldName: 'LastModifiedDate', type: 'date' },
];

export default class TableView extends LightningElement {

        columns = columns;
        accounts;

        @wire(getAccountList)
        wiredAccounts({error, data}){
                if(data){
                        this.accounts = data;
                } else if(error){
                        // TODO: エラー処理(this.errors = error など)
                }
        }


}