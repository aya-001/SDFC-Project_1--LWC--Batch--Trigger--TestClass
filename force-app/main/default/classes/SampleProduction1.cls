public with sharing class SampleProduction1 {

    public String checkNum(Integer num){
        String retMessage;
        if(num > 10){
            retMessage = num + 'は10未満です';
        } else {
            retMessage = num + 'は10以上です';
        }
        return retMessage;
    }
}