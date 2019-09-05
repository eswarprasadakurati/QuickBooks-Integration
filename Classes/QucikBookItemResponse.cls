public class QucikBookItemResponse {
	public Item Item{get;set;}
	//public String time{get;set;}
	
    public class MetaData{
		public String LastUpdatedTime{get;set;}
		public String CreateTime{get;set;}
	}
	public class Item{
		public Boolean Taxable{get;set;}
		public IncomeAccountRef IncomeAccountRef{get;set;}
        public ParentRef ParentRef {get;set;}
        public Boolean SubItem {get;set;}
	//	public AssetAccountRef AssetAccountRef{get;set;}
		public Integer QtyOnHand{get;set;}
		public Boolean sparse{get;set;}
		public Integer PurchaseCost{get;set;}
        public String Description{get;set;}
		public Boolean Active{get;set;}
		public Integer UnitPrice{get;set;}
		public String SyncToken{get;set;}
		public Boolean TrackQtyOnHand{get;set;}
		public String InvStartDate{get;set;}
		public String Name{get;set;}
		public String Type{get;set;}
		public String Id{get;set;}
	//	public ExpenseAccountRef ExpenseAccountRef{get;set;}
		public String domain{get;set;}
		public MetaData MetaData{get;set;}
		public String FullyQualifiedName{get;set;}
	}
    public class ParentRef {
		public String value {get;set;} 
		public String name {get;set;} 
    }
	public class IncomeAccountRef{
		public String value{get;set;}
		public String name{get;set;}
	} /*
	 public class ExpenseAccountRef{
		public String name{get;set;}
		public String value{get;set;}
	}
	public class AssetAccountRef{
		public String name{get;set;}
		public String value{get;set;}
	}*/
}