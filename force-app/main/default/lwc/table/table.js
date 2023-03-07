import { LightningElement } from 'lwc';

const columns = [
        { label: '会社名', fieldName: 'name' },
        { label: 'Website', fieldName: 'website', type: 'url' },
        { label: '電話', fieldName: 'phone', type: 'phone' },
        { label: '設立日', fieldName: 'foundingDate', type: 'date' },
];

export default class Table extends LightningElement {
        columns = columns;
        data = [
            {
                id: 'a',
                name: '株式会社テラスカイ',
                website: 'https://www.terrasky.co.jp/',
                phone: '03-5255-3410',
                foundingDate: '2006-03-01',
            },
            {
                id: 'b',
                name: '株式会社テラスカイ365',
                website: 'https://www.sky365.co.jp/',
                phone: '011-727-0365',
                foundingDate: '2014-05-19',
            }];
}