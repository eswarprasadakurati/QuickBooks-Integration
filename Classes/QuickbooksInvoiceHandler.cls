global class QuickbooksInvoiceHandler {
    public QuickbooksInvoiceHandler() {
        
    }
    webservice  static void createInvoiceInQB(Id[] orderLineIds, String Order_Id){
        String origin ='';
        String query='SELECT Line_Description__c,Id,List_Price__c,OrderID__c,';
                query+='ProductID__r.QuickbooksID__c,Quantity__c,QuickBooks_Error_message__c,';
                query+='QuickBooks_Invoice_Number__c,Total_Price__c,Unit_price__c FROM Order_LineItems__c WHERE ';
             
            boolean flag = false;
            origin ='invoice';
            System.debug(Order_Id);
            Order_Id+='';
            
            if(Order_Id.length()!=0&& [select Order_Status__c from Order where id=:Order_Id and  Order_Status__c='Completed'].size()==1){
              
               query +=' OrderID__c=:Order_Id  and QuickBooks_Invoice_Number__c=null';

                HTTPRequest req= new HttpRequest();
                req.setBody(JSON.serialize(new QucikBookInvoiceRequest(Database.query(query))));
                HttpResponse res;
                res= new QuickBooksHttpWrapper().setRequest(req,'invoice');
                               
                System.debug(res.getbody());
                if(res.getStatusCode()==200){
                    System.debug(res.getbody());
                    QucikBookInvoiceResponse c=(QucikBookInvoiceResponse)JSON.deserialize(res.getbody(),QucikBookInvoiceResponse.class);
                             
                    List<Order_LineItems__c> updateOrderItemList = new list<Order_LineItems__c>();
                    for(Order_LineItems__c OI:Database.query(query)){
                        if(OI.QuickBooks_Invoice_Number__c==null){
                            OI.QuickBooks_Invoice_Number__c=c.Invoice.DocNumber;
                            OI.QuickBooks_Error_message__c = '';
                            updateOrderItemList.add(OI);
                        }                            
                    }
                    update updateOrderItemList;
                    update new Order(Id=Order_Id,QuickBooks_Invoice_Number__c=c.Invoice.DocNumber,QuickBooks_Error_message__c='');                    
                }else{
                    update new Order(Id=Order_Id,QuickBooks_Error_message__c=res.getbody());
                        System.debug('Something went wrong');
                }
                
            }else if(orderLineIds!=null && orderLineIds.size()!=0){
                query+= 'Id in: orderLineIds and QuickBooks_Invoice_Number__c=null';
                if([select QuickBooks_Invoice_Number__c from Order_LineItems__c 
                            where QuickBooks_Invoice_Number__c!=null and  id=:orderLineIds].size()==0){
                    flag = true;
                }
                for(Order_LineItems__c OrderItemObj:[select QuickBooks_Invoice_Number__c from Order_LineItems__c where 
                                            QuickBooks_Invoice_Number__c=null and
                                            id=:orderLineIds]){
                   flag=false;
                    
                }
                if(flag){
                    return;
                }
                List<Order_LineItems__c> updateOrderItemList = new list<Order_LineItems__c>();
                HTTPRequest req= new HttpRequest();
                req.setBody(JSON.serialize(new QucikBookInvoiceRequest(Database.query(query))));
                HttpResponse res=null;// new QuickBooksHttpWrapper().setRequest(req,'invoice');
                res= new QuickBooksHttpWrapper().setRequest(req,'invoice');
                
                System.debug(res.getbody());
                if(res.getStatusCode()==200){
                    System.debug(res.getbody());
                    QucikBookInvoiceResponse c=(QucikBookInvoiceResponse)JSON.deserialize(res.getbody(),QucikBookInvoiceResponse.class);
                    Order_Id = null;
                    for(Order_LineItems__c OI:Database.query(query)){
                            Order_Id = OI.OrderID__c;
                            OI.QuickBooks_Invoice_Number__c=c.Invoice.DocNumber;
                            OI.QuickBooks_Error_message__c = '';
                            updateOrderItemList.add(OI);
                        System.debug('----');
                      }                    
                  }else{
                    //update new Order(Id=Order_Id,QuickBooks_Error_message__c=res.getbody());
                        System.debug('Something went wrong');
                }
                   update updateOrderItemList;
            }
      }
    @auraenabled
          public static List<Order_LineItems__c> listlineorder(string orderid){
              List<Order_LineItems__c> orderLineItemsList=new List<Order_LineItems__c>();
              orderLineItemsList=[SELECT name,Order_Status__c,Line_Description__c,Id,List_Price__c,ProductID__r.Name,OrderID__c,ProductID__r.QuickbooksID__c,Quantity__c,QuickBooks_Error_message__c,QuickBooks_Invoice_Number__c,Total_Price__c,Unit_price__c FROM Order_LineItems__c WHERE OrderID__c=:orderid];
              return orderLineItemsList;
          }
    @auraenabled
    public static string updateStatus(List<id> lineItemId){
        createInvoiceInQB(lineItemId,null);
        return null;
    }  
   @auraenabled
    public static string UpdateAllitems(id orderid){
        order ordercompl=[select id,QuickBooks_Invoice_Number__c,Order_Status__c from order where id=:orderid];
        if(ordercompl.QuickBooks_Invoice_Number__c == null && ordercompl.Order_Status__c =='Completed' ){
           createInvoiceInQB(null,orderid);
        	return 'success';
        }
        else {
            return 'failure';
        }       
    }
}