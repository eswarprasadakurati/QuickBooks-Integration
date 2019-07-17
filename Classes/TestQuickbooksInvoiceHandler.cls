@isTest
public class TestQuickbooksInvoiceHandler {
    @testSetup
    public static void setup(){
        Extentia_SIM__SalesInfoMapSetting__c temp = new Extentia_SIM__SalesInfoMapSetting__c();
        temp.Name='IsGoogleKeyValid';
        temp.Extentia_SIM__Value__c='Yes';
        insert temp;
        temp = new Extentia_SIM__SalesInfoMapSetting__c();
        temp.Name='IsGoogleAPIQueryLimitExceeded';
        temp.Extentia_SIM__Value__c='Yes';
        insert temp;
        
        Account ta = new Account();
        ta.Name='testts';
        insert ta;
        
        Opportunity testOpportunity = new Opportunity(accountId=ta.Id,Name = 'Test Opportunity Triggers',CloseDate = system.today(), ForecastCategoryName='pipeline',Frequency_Discount__c='testq',StageName = 'Sourcing Demand', Amount  = 12);
        insert testOpportunity;
        
        Quote testQuote=new Quote();
        testQuote.Name='SampleQuote';
        testQuote.opportunityid = testOpportunity.id;
        insert testQuote;
        
        
        
        product2 prd2=new product2();
        prd2.Name='Test Product';
        prd2.Account_Name__c='91';
        prd2.Taxable__c=false; 
        prd2.IsActive=true;
        prd2.Product_Type__c='service';
        prd2.Description='sample product'; 
        prd2.Sub_Product__c=true;
        insert prd2;
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = prd2.Id, UnitPrice = 1000, IsActive = true);
        insert pbe;
        
        Quote testQuote1=new Quote();
        testQuote1.Name='SampleQuote';
        testQuote1.opportunityid = testOpportunity.id;
        testQuote1.Pricebook2Id =Test.getStandardPricebookId();
        insert testQuote1;
        
        OpportunityLineItem OpportunityLineItemObj = new OpportunityLineItem();
        OpportunityLineItemObj.Product2Id  = prd2.Id;
        OpportunityLineItemObj.OpportunityId=testOpportunity.Id;  
        OpportunityLineItemObj.Quantity=10;
        OpportunityLineItemObj.Description='sample';
        OpportunityLineItemObj.UnitPrice=12;
        OpportunityLineItemObj.PricebookEntryId=pbe.id;
        insert OpportunityLineItemObj;
        update testOpportunity;
        
        QuoteLineItem QuoteLineItemObj = new QuoteLineItem();
        QuoteLineItemObj.Product2Id  = prd2.Id;
        QuoteLineItemObj.QuoteId=testQuote1.Id;
        QuoteLineItemObj.Quantity=10; 
        QuoteLineItemObj.UnitPrice=12;
        QuoteLineItemObj.OpportunityLineItemId =  OpportunityLineItemObj.id;
        QuoteLineItemObj.PricebookEntryId=pbe.id;
        insert QuoteLineItemObj;
        
        testQuote1.Status='Accepted';
        update testQuote1;
       
        update new Order(Id=[select Id from order limit 1].Id,Order_Status__c='Completed');
        
        Order testOrder=new Order();
        testOrder.Name='SampleOrder';
        testOrder.opportunityid = testOpportunity.id;
        testOrder.AccountId = ta.id;
        testOrder.Order_Status__c= 'Completed';
        testOrder.EffectiveDate=System.today();
        testOrder.Status='Draft';
        insert testOrder;
        
    }
    static testMethod void InvoiceOne(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success',
                                                                          '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"155","SyncToken":"0","MetaData":{"CreateTime":"2018-12-26T21:41:08-08:00","LastUpdatedTime":"2018-12-26T21:41:08-08:00"},"CustomField":[{"DefinitionId":"1","Name":"Crew #","Type":"StringType"}],"DocNumber":"1048","TxnDate":"2018-12-26","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"sample product","Amount":50.00,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"31","name":"Adv-Agency:1/3 Page 4/Color"},"UnitPrice":5,"Qty":10,"TaxCodeRef":{"value":"NON"}}},{"Amount":50.00,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"2","name":"Bill Windsurf Shop"},"BillAddr":{"Id":"3","Line1":"12 Ocean Dr.","City":"Half Moon Bay","CountrySubDivisionCode":"CA","PostalCode":"94213","Lat":"37.4307072","Long":"-122.4295234"},"DueDate":"2019-01-25","TotalAmt":50.00,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":50.00},"time":"2018-12-26T21:41:08.174-08:00"}',new map<string,string>() ));
        
        QuickbooksInvoiceHandler.createInvoiceInQB(new list<Id>(new map<Id, Order_LineItems__c>([select id from Order_LineItems__c ]).keyset()),
                                                   [select Id from order limit 1].Id );
        
        Test.stopTest();
    }
    static testMethod void InvoiceTwo(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success',
                                                                          '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"155","SyncToken":"0","MetaData":{"CreateTime":"2018-12-26T21:41:08-08:00","LastUpdatedTime":"2018-12-26T21:41:08-08:00"},"CustomField":[{"DefinitionId":"1","Name":"Crew #","Type":"StringType"}],"DocNumber":"1048","TxnDate":"2018-12-26","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"sample product","Amount":50.00,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"31","name":"Adv-Agency:1/3 Page 4/Color"},"UnitPrice":5,"Qty":10,"TaxCodeRef":{"value":"NON"}}},{"Amount":50.00,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"2","name":"Bill Windsurf Shop"},"BillAddr":{"Id":"3","Line1":"12 Ocean Dr.","City":"Half Moon Bay","CountrySubDivisionCode":"CA","PostalCode":"94213","Lat":"37.4307072","Long":"-122.4295234"},"DueDate":"2019-01-25","TotalAmt":50.00,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":50.00},"time":"2018-12-26T21:41:08.174-08:00"}',new map<string,string>() ));
        
        QuickbooksInvoiceHandler.createInvoiceInQB(new list<Id>(new map<Id, Order_LineItems__c>([select id from Order_LineItems__c ]).keyset()), '' );
        
        Test.stopTest();
    }
    static testMethod void QucikBookInvoiceResponse(){
        QucikBookInvoiceResponse.parse('{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"155","SyncToken":"0","MetaData":{"CreateTime":"2018-12-26T21:41:08-08:00","LastUpdatedTime":"2018-12-26T21:41:08-08:00"},"CustomField":[{"DefinitionId":"1","Name":"Crew #","Type":"StringType"}],"DocNumber":"1048","TxnDate":"2018-12-26","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"sample product","Amount":50.00,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"31","name":"Adv-Agency:1/3 Page 4/Color"},"UnitPrice":5,"Qty":10,"TaxCodeRef":{"value":"NON"}}},{"Amount":50.00,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"2","name":"Bill Windsurf Shop"},"BillAddr":{"Id":"3","Line1":"12 Ocean Dr.","City":"Half Moon Bay","CountrySubDivisionCode":"CA","PostalCode":"94213","Lat":"37.4307072","Long":"-122.4295234"},"DueDate":"2019-01-25","TotalAmt":50.00,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":50.00},"time":"2018-12-26T21:41:08.174-08:00"}');
        
    }
    static testMethod void listlineorder(){
        string orderid='rrrtf';
        QuickbooksInvoiceHandler.listlineorder(orderid);
    }
    
    static testMethod void UpdateAllitems(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success',
                                                                          '{"Invoice":{"Deposit":0,"AllowIPNPayment":false,"AllowOnlinePayment":false,"AllowOnlineCreditCardPayment":false,"AllowOnlineACHPayment":false,"domain":"QBO","sparse":false,"Id":"155","SyncToken":"0","MetaData":{"CreateTime":"2018-12-26T21:41:08-08:00","LastUpdatedTime":"2018-12-26T21:41:08-08:00"},"CustomField":[{"DefinitionId":"1","Name":"Crew #","Type":"StringType"}],"DocNumber":"1048","TxnDate":"2018-12-26","CurrencyRef":{"value":"USD","name":"United States Dollar"},"LinkedTxn":[],"Line":[{"Id":"1","LineNum":1,"Description":"sample product","Amount":50.00,"DetailType":"SalesItemLineDetail","SalesItemLineDetail":{"ItemRef":{"value":"31","name":"Adv-Agency:1/3 Page 4/Color"},"UnitPrice":5,"Qty":10,"TaxCodeRef":{"value":"NON"}}},{"Amount":50.00,"DetailType":"SubTotalLineDetail","SubTotalLineDetail":{}}],"TxnTaxDetail":{"TotalTax":0},"CustomerRef":{"value":"2","name":"Bill Windsurf Shop"},"BillAddr":{"Id":"3","Line1":"12 Ocean Dr.","City":"Half Moon Bay","CountrySubDivisionCode":"CA","PostalCode":"94213","Lat":"37.4307072","Long":"-122.4295234"},"DueDate":"2019-01-25","TotalAmt":50.00,"ApplyTaxAfterDiscount":false,"PrintStatus":"NeedToPrint","EmailStatus":"NotSet","Balance":50.00},"time":"2018-12-26T21:41:08.174-08:00"}',new map<string,string>() ));
        
        Id orderid=[Select id from Order limit 1].id;
        QuickbooksInvoiceHandler.UpdateAllitems(orderid);
        Test.stopTest();
    }
}