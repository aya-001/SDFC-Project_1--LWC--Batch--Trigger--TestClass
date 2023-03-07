trigger LeadTrigger on Lead (before insert) {
    for(Lead ldRec    : Trigger.new){
        if(ldRec.Company == '株式会社キット'){
            ldRec.FirstName = '太郎';
        } else if(ldRec.Company == '株式会社Bee'){
            ldRec.addError('カスタムエラー');
        }
    }
}
