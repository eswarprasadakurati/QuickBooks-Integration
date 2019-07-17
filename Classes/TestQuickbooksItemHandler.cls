@isTest
public class TestQuickbooksItemHandler {
    @testSetup static void setup() {
        product2 prd2=new product2();
        prd2.Account_Name__c='91';
         prd2.Name='Test Product';
         prd2.Taxable__c=false; 
         prd2.IsActive=true;
         prd2.Track_Quantity_on_Hand__c=false;
         prd2.Product_Type__c='service';
         prd2.Quantity_on_Hand__c=10;
         prd2.Description='sample product'; 
         prd2.Sub_Product__c=false;
        insert prd2;
        prd2=new product2();
        prd2.Account_Name__c='91';
         prd2.Name='Test Product1';
         prd2.Taxable__c=false; 
         prd2.IsActive=true;
         prd2.Track_Quantity_on_Hand__c=false;
         prd2.Product_Type__c='service';
         prd2.Quantity_on_Hand__c=10;
         prd2.Description='sample product'; 
         prd2.Sub_Product__c=true;
        
        insert prd2;
    }
    static testMethod void productCaseOne()
    {        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success','{ "Item": { "Name": "Services", "Active": true, "FullyQualifiedName": "Services", "Taxable": false, "UnitPrice": 0, "Type": "Service", "IncomeAccountRef": { "value": "1", "name": "Services" }, "PurchaseCost": 0, "TrackQtyOnHand": false, "domain": "QBO", "sparse": false, "Id": "1", "SyncToken": "0", "MetaData": { "CreateTime": "2018-11-09T14:42:05-08:00", "LastUpdatedTime": "2018-11-09T14:42:05-08:00" } }, "time": "2018-12-26T21:57:47.537-08:00" }',new map<string,string>() ));
         
        QuickbooksItemHandler.createItemInQB([select Id,Account_Name__c,Name,Taxable__c,IsActive,Track_Quantity_on_Hand__c,Product_Type__c,Quantity_on_Hand__c,Description, Sub_Product__c from product2 where Sub_Product__c=false limit 1]);
        System.scheduleBatch(new QuickBooksItemBatch(),'test',1);
         
        Test.stopTest();
                
    }
    static testMethod void productCaseTwo()
    {       
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success','{ "Item": { "Name": "Services", "Active": true, "FullyQualifiedName": "Services", "Taxable": false, "UnitPrice": 0, "Type": "Service", "IncomeAccountRef": { "value": "1", "name": "Services" }, "PurchaseCost": 0, "TrackQtyOnHand": false, "domain": "QBO", "sparse": false, "Id": "1", "SyncToken": "0", "MetaData": { "CreateTime": "2018-11-09T14:42:05-08:00", "LastUpdatedTime": "2018-11-09T14:42:05-08:00" } }, "time": "2018-12-26T21:57:47.537-08:00" }',new map<string,string>() ));
         
        QuickbooksItemHandler.createItemInQB([select Id,Account_Name__c,Name,Taxable__c,IsActive,Track_Quantity_on_Hand__c,Product_Type__c,Quantity_on_Hand__c,Description, Sub_Product__c from product2 where Sub_Product__c=true limit 1]);
        Test.stopTest();
    }
    static testmethod void QucikBookItemResponse(){
        QucikBookItemResponse QucikBookItemResponseObj = new QucikBookItemResponse();
        QucikBookItemResponse.Item  item= new QucikBookItemResponse.Item();
        QucikBookItemResponse.IncomeAccountRef IncomeAccountRef = new QucikBookItemResponse.IncomeAccountRef();
        IncomeAccountRef.value='test';
        IncomeAccountRef.name='test';
        QucikBookItemResponse.ParentRef ParentRef = new QucikBookItemResponse.ParentRef();
        ParentRef.value='test';
        ParentRef.name='test';
        QucikBookItemResponse.MetaData MetaData = new QucikBookItemResponse.MetaData();
        MetaData.LastUpdatedTime='test';
        MetaData.CreateTime='test';
        
          item.Taxable=false;
		  item.IncomeAccountRef=IncomeAccountRef;
          item.ParentRef =ParentRef;
          item.SubItem =true;
		  item.QtyOnHand=10;
		  item.sparse=false;
		  item.PurchaseCost=38;
          item.Description='test';
		  item.Active=true;
		  item.UnitPrice=32;
		  item.SyncToken='test';
		  item.TrackQtyOnHand=true;
		  item.InvStartDate='test';
		  item.Name='test';
		  item.Type='test';
		  item.Id='test';
		  item.domain='test';
	   	  item.MetaData=MetaData;
		  item.FullyQualifiedName='test';
        QucikBookItemResponseObj.item = item;
    }
    static testMethod void updateStatus(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success','{ "Item": { "Name": "Services", "Active": true, "FullyQualifiedName": "Services", "Taxable": false, "UnitPrice": 0, "Type": "Service", "IncomeAccountRef": { "value": "1", "name": "Services" }, "PurchaseCost": 0, "TrackQtyOnHand": false, "domain": "QBO", "sparse": false, "Id": "1", "SyncToken": "0", "MetaData": { "CreateTime": "2018-11-09T14:42:05-08:00", "LastUpdatedTime": "2018-11-09T14:42:05-08:00" } }, "time": "2018-12-26T21:57:47.537-08:00" }',new map<string,string>() ));
         
       Id oId=[select Id from product2 limit 1].id;
        QuickbooksItemHandler.updateStatus(oId);
        Test.stopTest();
    }
}