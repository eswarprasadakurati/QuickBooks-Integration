public class QucikBookInvoiceResponse{
	public cls_Invoice Invoice;
	//public String time;	//2018-12-01T22:56:45.946-08:00
	public class cls_Invoice {
		/*public Integer Deposit;	//0
		public boolean AllowIPNPayment;
		public boolean AllowOnlinePayment;
		public boolean AllowOnlineCreditCardPayment;
		public boolean AllowOnlineACHPayment;
		public String domain;	//QBO
		public boolean sparse;
		public String Id;	//615
		public String SyncToken;	//0
		//public cls_MetaData MetaData;
		//public cls_CustomField[] CustomField;
		*/public String DocNumber;	//1046
		//public String TxnDate;	//2018-12-01
		/*public cls_CurrencyRef CurrencyRef;
		public cls_LinkedTxn[] LinkedTxn;
		public cls_Line[] Line;
		public cls_TxnTaxDetail TxnTaxDetail;
		public cls_CustomerRef CustomerRef;
		public cls_BillAddr BillAddr;
		public cls_ShipAddr ShipAddr;
		public String DueDate;	//2018-12-31
		public Integer TotalAmt;	//1500
		public boolean ApplyTaxAfterDiscount;
		public String PrintStatus;	//NeedToPrint
		public String EmailStatus;	//NotSet
		public Integer Balance;	//1500
		*/
	}
	/*class cls_MetaData {
		public String CreateTime;	//2018-12-01T22:56:46-08:00
		public String LastUpdatedTime;	//2018-12-01T22:56:46-08:00
	}
	class cls_CustomField {
		public String DefinitionId;	//1
		public String Name;	//Crew #
		public String Type;	//StringType
	}
	class cls_CurrencyRef {
		public String value;	//USD
		public String name;	//United States Dollar
	}
	class cls_LinkedTxn {
	}
	class cls_Line {
		public String Id;	//1
		public Integer LineNum;	//1
		public Integer Amount;	//1500
		public String DetailType;	//SalesItemLineDetail
		public cls_SalesItemLineDetail SalesItemLineDetail;
	}*/
	class cls_SalesItemLineDetail {
		public cls_ItemRef ItemRef;
		public Integer UnitPrice;	//1500
		public Integer Qty;	//1
		public cls_TaxCodeRef TaxCodeRef;
	}
	class cls_ItemRef {
		public String value;	//268
		public String name;	//E-letter:Add leads to E-lert
	}
	class cls_TaxCodeRef {
		public String value;	//NON
	}
	class cls_TxnTaxDetail {
		public Integer TotalTax;	//0
	}   /*
	class cls_CustomerRef {
		public String value;	//1
		public String name;	//Amy's Bird Sanctuary
	} 
	class cls_BillAddr {
		public String Id;	//2
		public String Line1;	//4581 Finch St.
		public String City;	//Bayshore
		public String CountrySubDivisionCode;	//CA
		public String PostalCode;	//94326
		public String Lat;	//INVALID
		//public String Long;	//INVALID
	}
	class cls_ShipAddr {
		public String Id;	//2
		public String Line1;	//4581 Finch St.
		public String City;	//Bayshore
		public String CountrySubDivisionCode;	//CA
		public String PostalCode;	//94326
		public String Lat;	//INVALID
		//public String Long;	//INVALID
	}*/
	public static QucikBookInvoiceResponse parse(String json){
		return (QucikBookInvoiceResponse) System.JSON.deserialize(json, QucikBookInvoiceResponse.class);
	}
}