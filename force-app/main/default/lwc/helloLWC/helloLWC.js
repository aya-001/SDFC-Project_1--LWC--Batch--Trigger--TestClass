import { LightningElement } from 'lwc';

export default class HelloLWC extends LightningElement {
        name = '佐藤';
        changeHandler(event) {
                this.name = event.target.value;
        }

        get message(){
                return '今日の日付：' + new Date().toDateString();
        }
}