public class QucikBookInvoiceRequest {
	public class Line {
		public String Description;
		public Double Amount;
		public String DetailType;
		public SalesItemLineDetail SalesItemLineDetail;
	}
    //public String TxnDate{get;set;} 
    public QucikBookInvoiceRequest(){
    //    DueDate= '2019-01-23';
        //TxnDate= '2018-12-06';
    }
	public List<Line> Line;
	public CustomerRef CustomerRef;
    //public String DueDate{get;set;}
	public class SalesItemLineDetail {
		public ItemRef ItemRef;
		public Integer UnitPrice;
		public Integer Qty;
	}

	public class ItemRef {
		public String value;
		//public String name;
	}

	public class CustomerRef {
		public String value;
	}
	public QucikBookInvoiceRequest(list<Order_LineItems__c> OrderItemList){
		Line = new list<Line>();
		for(Order_LineItems__c OrderLineObj: OrderItemList){
			Line QucikBookInvoiceRequestLine = new Line();
			QucikBookInvoiceRequestLine.Description=OrderLineObj.Line_Description__c;
			QucikBookInvoiceRequestLine.Amount=OrderLineObj.Total_Price__c;
			QucikBookInvoiceRequestLine.DetailType='SalesItemLineDetail';

			ItemRef ItemRefObj = new ItemRef();
			ItemRefObj.value =OrderLineObj.ProductID__r.QuickbooksID__c;
			
			SalesItemLineDetail SalesItemLineDetailObj = new SalesItemLineDetail();
			SalesItemLineDetailObj.ItemRef = ItemRefObj;
			SalesItemLineDetailObj.UnitPrice= OrderLineObj.Unit_price__c==null?0:Integer.valueOf(OrderLineObj.Unit_price__c);
			SalesItemLineDetailObj.Qty = OrderLineObj.Quantity__c==null?0:Integer.valueOf(OrderLineObj.Quantity__c);

			QucikBookInvoiceRequestLine.SalesItemLineDetail = SalesItemLineDetailObj;
			Line.add(QucikBookInvoiceRequestLine);
		}
		CustomerRef = new CustomerRef();
		CustomerRef.value ='2';
	}
}