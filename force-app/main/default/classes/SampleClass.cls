public with sharing class SampleClass {
    public SampleClass() {




        
        /*          
        
        



         2.Salesforce IDは本番組織とSandBoxで同じ値になることがある
         3.主従関係の参照先を自分のオブジェクトにすることはできない

        取引先責任者の[姓][名][誕生日][部署][作成者]項目を「[部署]が"ソリューション部"と一致しない」という条件で取得して、さらに[誕生日]の昇順で表示してください。
        SELECT LastName, FirstName, Birthdate, Department, CreatedById
        FROM Contact
        WHERE Department != 'ソリューション部' 
        ORDER BY Birthdate ASC NULL LAST

                                                                                     
        取引先の[名前][従業員数][都道府県(請求先)]項目を「[従業員数]が100人以上で[都道府県(請求先)]が"東京"または"神奈川"」という条件で取得してください。
        SELECT Name, NumberOfEmployees, BillingState
        FROM Account
        WHERE NumberOfEmployees >= 100 AND (BillingState = '東京' OR BillingState = '神奈川')
        　　　　　　　　　　　　　　　　　　　　　　AND BillingState in( '東京' , '神奈川' )



        [従業員数]が100人以上の取引先（[取引先名][従業員数]）に紐づく取引先責任者（[姓][名][メール]）を取得してください。

        SELECT Name, NumberOfEmployees,
        (SELECT LastName, FirstName, Email 
        FROM Contacts)
        FROM Account　取引先
        WHERE NumberOfEmployees >= 100


        クローズされたケースを[原因]でグルーピングして、それぞれの合計件数を取得してください。
        SELECT Reason, COUNT(Id)
        FROM Case
        WHERE isClosed = true
        GROUP BY Reason

        不成立となっていない商談のレコードを[フェーズ]でグルーピングして、さらにグルーピング結果から[金額]を合計した値が100万以上の結果を取得してください。
        SELECT StageName, SUM(Amount)
        FROM Opportunity
         WHERE StageName != 'Closed Lost'
        GROUP BY StageName
         HAVING SUM(Amount) >= 1000000


         取引先から[最終更新日]が今日のレコードを取得してください。（システム項目）
        SELECT Name, LastModifiedDate
        FROM Account
        WHERE LastModifiedDate = TODAY


         商談から[完了予定日]が今会計年度のレコードを取得してください。
        SELECT Name, CloseDate
        FROM Opportunity
        WHERE CloseDate = THIS_FISCAL_YEAR


        商談から成立したレコードのみ取得し、月別の[金額]の合計を表示してください。また、月は昇順で表示してください。
        SELECT SUM(Amount)
        FROM Opportunities
        WHERE Stage = "Won"
        ORDER BY month Asc; 
        
        SELECT CALENDAR_MONTH(CloseDate), SUM(Amount)
        FROM Opportunity
        WHERE isWon = true    //Stage Name = 'Closed Won'
        GROUP BY CALENDAR_MONTH(CloseDate)
        ORDER BY CALENDAR_MONTH(CloseDate)
        
        
        */


    }
}
