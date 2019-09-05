public class QucikBookItemRequest {
    public class ParentAccountWrapper{
        public IncomeAccountRef IncomeAccountRef{get;set;}
        public String InvStartDate{get;set;}
        public Integer QtyOnHand{get;set;}
        public String Type{get;set;}
        public String Name{get;set;}
        public Boolean Taxable {get;set;}
        public String Description{get;set;}
       // public Boolean SubItem {get;set;} 
        //public ParentRef ParentRef {get;set;}
        // public ExpenseAccountRef ExpenseAccountRef{get;set;}
        // public AssetAccountRef AssetAccountRef{get;set;}
        public Boolean TrackQtyOnHand{get;set;}
        
        public ParentAccountWrapper(boolean TrackQtyOnHand, String Name, Integer QtyOnHand, String Type, Boolean Taxable, String Description,Boolean SubItem, Date InvStartDate, /*ParentRef ParentRef, */ IncomeAccountRef IncomeAccountRef /*, AssetAccountRef AssetAccountRef, ExpenseAccountRef ExpenseAccountRef*/){
            this.TrackQtyOnHand = TrackQtyOnHand;
            this.Name = Name;
            this.QtyOnHand = QtyOnHand;
            this.Type = Type;
            this.Taxable = Taxable;
            this.Description = Description;
           // this.SubItem = SubItem;       
            this.InvStartDate=String.valueOf(InvStartDate); // System.today()
            //this.ParentRef = ParentRef;
            this.IncomeAccountRef = IncomeAccountRef;
            // this.AssetAccountRef = AssetAccountRef;
            //  this.ExpenseAccountRef = ExpenseAccountRef;
        }        
    }
    
    public class subAccountWrapper{
        public IncomeAccountRef IncomeAccountRef{get;set;}
        public String InvStartDate{get;set;}
        public Integer QtyOnHand{get;set;}
        public String Type{get;set;}
        public String Name{get;set;}
        public Boolean Taxable {get;set;}
        public String Description{get;set;}
        public Boolean SubItem {get;set;} 
        public ParentRef ParentRef {get;set;}
        // public ExpenseAccountRef ExpenseAccountRef{get;set;}
        // public AssetAccountRef AssetAccountRef{get;set;}
        public Boolean TrackQtyOnHand{get;set;}
        
        public subAccountWrapper(boolean TrackQtyOnHand, String Name, Integer QtyOnHand, String Type, Boolean Taxable, String Description,Boolean SubItem, Date InvStartDate, ParentRef ParentRef,  IncomeAccountRef IncomeAccountRef /*, AssetAccountRef AssetAccountRef, ExpenseAccountRef ExpenseAccountRef*/){
            this.TrackQtyOnHand = TrackQtyOnHand;
            this.Name = Name;
            this.QtyOnHand = QtyOnHand;
            this.Type = Type;
            this.Taxable = Taxable;
            this.Description = Description;
            this.SubItem = SubItem;       
            this.InvStartDate=String.valueOf(InvStartDate); // System.today()
            this.ParentRef = ParentRef;
            this.IncomeAccountRef = IncomeAccountRef;
            // this.AssetAccountRef = AssetAccountRef;
            //  this.ExpenseAccountRef = ExpenseAccountRef;
        }        
    }
    
    /*
    public IncomeAccountRef IncomeAccountRef{get;set;}
	public String InvStartDate{get;set;}
	public Integer QtyOnHand{get;set;}
	public String Type{get;set;}
	public String Name{get;set;}
    public Boolean Taxable {get;set;}
    public String Description{get;set;}
    public Boolean SubItem {get;set;} 
	public ParentRef ParentRef {get;set;}
    // public ExpenseAccountRef ExpenseAccountRef{get;set;}
    // public AssetAccountRef AssetAccountRef{get;set;}
	public Boolean TrackQtyOnHand{get;set;}
    
    public QucikBookItemRequest(boolean TrackQtyOnHand, String Name, Integer QtyOnHand, String Type, Boolean Taxable, String Description,Boolean SubItem, Date InvStartDate, ParentRef ParentRef,  IncomeAccountRef IncomeAccountRef ){
        this.TrackQtyOnHand = TrackQtyOnHand;
        this.Name = Name;
        this.QtyOnHand = QtyOnHand;
        this.Type = Type;
        this.Taxable = Taxable;
        this.Description = Description;
        this.SubItem = SubItem;       
        this.InvStartDate=String.valueOf(InvStartDate); // System.today()
        this.ParentRef = ParentRef;
        this.IncomeAccountRef = IncomeAccountRef;
        // this.AssetAccountRef = AssetAccountRef;
        //  this.ExpenseAccountRef = ExpenseAccountRef;
    }
    */
    public class ParentRef {
		public String value {get;set;} 
		public String name {get;set;} 
        public ParentRef(String name, String value){
            this.name = name;
            this.value = value;
   		 }
    }   
    public class IncomeAccountRef{
		public String value{get;set;}
		public String name{get;set;}
        public IncomeAccountRef(String name, String value){
            this.name = name;
            this.value = value;
        }
	}
    	
    
}