public class QuickbooksItemHandler {
    @AuraEnabled
    public static void createItemInQB(product2 product){
        product = [select Id,Name,Taxable__c,Parent_Product__r.Name, Account_Name__c,Track_Quantity_on_Hand__c,
                   Product_Type__c, Quantity_on_Hand__c, Description, Sub_Product__c,Parent_Product__r.QuickbooksID__c  
                   from product2 where id=:product.id limit 1];
        
        //QuickBookDetail__mdt  QuickBookDetail = [SELECT Id, DeveloperName, MasterLabel, Language,Accounting_Base_URL__c, NamespacePrefix, Label,minorversion__c, QualifiedApiName, Client_Secret__c, Client_Id__c, Refresh_Token__c, Scopes__c, Authorization_Code__c, Company_ID__c, Access_Token__c, Redirect_URI__c, OAuthbase_URI__c FROM QuickBookDetail__mdt where DeveloperName='quickbook' limit 1];    
        Integer QtyOnHand = (product.Quantity_on_Hand__c==null||product.Quantity_on_Hand__c==0)?(0):Integer.valueof(product.Quantity_on_Hand__c);
        string  type = product.Product_Type__c==null?'Service':product.Product_Type__c;
        HTTPRequest req= new HttpRequest();
        if(product.Account_Name__c!=null){
				Map<String,String> quickbookId_ProductName = new map<String,String>();
				for( Schema.PicklistEntry pickListVal : product2.Account_Name__c.getDescribe().getPicklistValues()){
            		quickbookId_ProductName.put(pickListVal.getValue(),pickListVal.getLabel());
				} 
                          
                      if(product.Sub_Product__c)
                       req.setBody(JSON.serialize(new QucikBookItemRequest.subAccountWrapper(
                        product.Track_Quantity_on_Hand__c,
                        product.Name,
                        QtyOnHand, type, product.Taxable__c, product.Description, product.Sub_Product__c, System.today(),
                        new QucikBookItemRequest.ParentRef(product.Parent_Product__r.Name, product.Parent_Product__r.QuickbooksID__c),
                        new QucikBookItemRequest.IncomeAccountRef(quickbookId_ProductName.get(product.Account_Name__c), product.Account_Name__c)
                           )));
                       else
                          req.setBody(JSON.serialize(new QucikBookItemRequest.ParentAccountWrapper(
                        product.Track_Quantity_on_Hand__c,
                        product.Name,
                        QtyOnHand, type, product.Taxable__c, product.Description, product.Sub_Product__c, System.today(),
                        new QucikBookItemRequest.IncomeAccountRef(quickbookId_ProductName.get(product.Account_Name__c), product.Account_Name__c))));
 
             }else{
            // System.debug('Something went wrong'); 
        }
        
        HttpResponse res=new QuickBooksHttpWrapper().setRequest(req,'item');
        
        if(res.getStatusCode()==200){
               System.debug(res.getbody());
            	QucikBookItemResponse c=(QucikBookItemResponse)JSON.deserialize(res.getbody(),QucikBookItemResponse.class);
            	update new Product2(Id=product.Id,QuickbooksID__c=c.Item.Id,QuickBooks_Error_message__c='');
            	System.debug(c.Item.Id);
        }else{
            	update new Product2(Id=product.Id,QuickBooks_Error_message__c=res.getbody());
                System.debug('Something went wrong');
        }
    }
    @AuraEnabled 
    public static string updateStatus(/*Product2 obj,*/String oId){
       string response='The product is getting Created in QuickBooks. Please refresh the page multiple times to get the update from Quickbooks. If Product is created successfully, you will see "QuickbooksID" for the product else you will see "QuickBooks Error message" in the related field.';
        Product2 Product=[select Id,QuickbooksID__c from product2 where id=:oId limit 1];
        if(product.QuickbooksID__c!=null){
           response='This Product already exists in Quickbooks';			
        }else{
            createItemInQB(product);
        }
        return response;
    }
}