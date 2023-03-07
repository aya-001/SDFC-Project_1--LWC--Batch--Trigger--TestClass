import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createRec from '@salesforce/apex/AccountInsertController.createAccRec';

export default class LdsCreateRecord extends LightningElement {
        accountId;
        name = '';

        // 取引先名の変更時にIDをクリア
        handleNameChange(event) {
                this.accountId = undefined;
                this.name = event.target.value;
        }

        // 取引先の登録
        createAccount() {
                // Accountオブジェクトを作成して取引先名をセット
                const recordInput = { sobjectType: 'Account'};
                recordInput.Name = this.name;

                // Apexメソッドをコール [acc]はメソッドの引数名
                createRec({ acc: recordInput})
                        // 成功した場合
                        .then(result => {
                                this.accountId = result.Id;
                                this.dispatchEvent(
                                        new ShowToastEvent({
                                                title: '成功',
                                                message: '取引先[' + result.Name + ']が登録されました',
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