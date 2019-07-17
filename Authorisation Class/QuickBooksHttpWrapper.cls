public class QuickBooksHttpWrapper implements Metadata.DeployCallback{
	public static QuickBookDetail__mdt QuickBookDetail {get;set;}
	public static String grant_type{get;set;}
    public static String authorization_code{get;set;}
    public static AuthorizationJSON responseJSON{get;set;}
    public static Boolean isAccessTokenExpired{get;set;}
    //public static QuickBookDetail__mdt QuickBookDetail{get;set;}
	static{
        QuickBookDetail = [SELECT Id, DeveloperName,Accounting_Base_URL__c, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName, Client_Secret__c,minorversion__c, Client_Id__c, Refresh_Token__c, Scopes__c, Authorization_Code__c, Company_ID__c, Access_Token__c, Redirect_URI__c, OAuthbase_URI__c FROM QuickBookDetail__mdt where DeveloperName='quickbook' limit 1];    
    }
	public HttpResponse setRequest(HTTPRequest req, String quickbookObj){
		httpEndPoints(req, quickbookObj);
		HttpResponse res=new Http().send(req);
		if(res.getStatus()=='Unauthorized'){
			grant_type ='refresh_token';
        	makeOauthHTTPRequest();
			httpEndPoints(req, quickbookObj);
            //Database.executeBatch(new Quickbook_Credentials_update_Batch(),1);
			res=new Http().send(req);
            isAccessTokenExpired= true;
		}
		return res;
	}
	public void httpEndPoints(HttpRequest req, String quickbookObj){
		if(quickbookObj=='item'){
			req.setendpoint(QuickBookDetail.Accounting_Base_URL__c+'v3/company/'+QuickBookDetail.Company_ID__c+'/item?minorversion='+QuickBookDetail.minorversion__c);
		}/*else if(quickbookObj=='account'){
			req.setendpoint(QuickBookDetail.Accounting_Base_URL__c+'v3/company/'+QuickBookDetail.Company_ID__c+'/account');
		}*/else if(quickbookObj=='invoice'){
            //v3/company/123146178322899/invoice?minorversion=4
            req.setendpoint(QuickBookDetail.Accounting_Base_URL__c+'v3/company/'+QuickBookDetail.Company_ID__c+'/invoice?minorversion='+QuickBookDetail.minorversion__c);
        }else{
			System.debug('Unknown Object');
		}
		req.setmethod('POST');
        req.setHeader('Accept', 'application/json');
        req.setHeader('content-type', 'application/json');
		req.setHeader('Authorization','Bearer '+QuickBookDetail.Access_Token__c);

	}

	public String makeOauthHTTPRequest(){
		String requestResponseState;
        try{
            requestResponseState ='Authorization succeeded for Quickbooks';
            HTTPRequest req= createOauthRequest();
            HttpResponse res;
            //if(!Test.isRunningTest())
            	res=new Http().send(req);
            /*if(Test.isRunningTest()){
                responseJSON=AuthorizationJSON.parse('{"token_type":"bearer","access_token":"eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..YTbzTdwfs5VESk-RUgV9Tg.GvVX6LkZzvC27PhmP32_aYPz4HgPOm-beMvHs2GLpwLVmirKsazGEnpK2cporaMucnTRSvyxoZKVzy-Hdc3loTAoA3oRLnBEuh9613wQMHZ-nuapjbodpLrUTLS-17u3YvF5rPJEQNXB1sSlVCeOPucStJgYXkKfF4qbK7mq8ewRN7tmARAZlvWgo7NEK_EHg0qDN3FCCSa0HH9QMAdBtdYVQkRuFiv2rSM0qz6wCollWn92ds0nzbuLtLqjd2bk-4ZjnKpAazn8XDaA_putOpN6wqmGEfUQwP-vtNgb_uSKp8vUi2vpaM_T47MJWx--D8aJ6JdS-GPFyK4vNB82pBMRks6gjt2x1qS_OtgNIvknuTNS2eF9lCbkRNpWkUI1_-SsemFFR8YUe4O7VnjsmDSg2SGNG14mHhvtskk0GjiOjwYdQJjraVvJgHVjZgoRmEj3vFCPWliFL6kilyv-uj5XKepoHX6qeKRpaCWJdHrmtZeJ3kvN1sFDdv8kkKfVn0AJA88HvPlF9LopCJekoXe0Wxlsn6XOWN_JkV5hP76LYGjpOB2GHWqy3BL92qpoGFq3Jbt48fqV0qXk1frdViWTmm5aPvGbygozXNlW4EYelCIWlZTjejKv41XZnuBe6DFRgP0dCqg612LRv2ghH9mIWrDN66lEbkWgIBjDqzZfgRW1ATmNbNjOzk6vMfAybaDZZuWCPkudN_LXEkq-X-ak9ywHiCzbR4jvL_bNe7-hgAWkHEryuW8VgtXtb2wFW7niozF6tcNL8KukGAGpsifuDYH_GvpkpVVjwbOnTnPsyR_yvabbSTwInbUiF3DahH9A1wZmqWcFSahjx8uNzQ.13XN6p-_3uHsdEWzLanCQA","x_refresh_token_expires_in":8726400,"refresh_token":"L011554378373EYhWemhzRr4EBMjugQ9ENpSRx8Dzi7PNmiVXi","expires_in":3600,"id_token":"eyJraWQiOiJPUElDUFJEMDkxODIwMTQiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI5Nzk1OTZlNy02MmI5LTQ5N2ItODQwMy03M2MyZDdkYmMzOTMiLCJhdWQiOlsiUTBxcENsdVZuMTluanREaGE4UnJ6SUxQZ0JPdlBhU2ZVZXdOQ1l6VFB4Y2p2REljRWQiXSwicmVhbG1pZCI6IjEyMzE0NjIxNzM4MzU4OSIsImF1dGhfdGltZSI6MTU0NTY1MTc2NiwiaXNzIjoiaHR0cHM6XC9cL29hdXRoLnBsYXRmb3JtLmludHVpdC5jb21cL29wXC92MSIsImV4cCI6MTU0NTY1NTU3MywiaWF0IjoxNTQ1NjUxOTczfQ.RPvxBA89WGu4QFr6UjIkTITPsaZZRj0fZNC9j8_KVFYCIk9VYMm8b_e6ASFeZ3njxf9D4r0y23ARg1E5l1jHinmlHLbiZmIZqhr0FXBfV69vyt9F8TRztHF0gOP5VwDqpIL7T461_3s7PyC73XR0SUeeCB7EwrIhzIRqo05sm1Q"}'
);
                QuickBookDetail.Access_Token__c = responseJSON.access_token;
            }else */if(res.getStatusCode()==200){
                responseJSON=AuthorizationJSON.parse(res.getbody());
                QuickBookDetail.Access_Token__c = responseJSON.access_token;  
            }else{
                requestResponseState='Something went wrong';
            }
        }catch(Exception e){
            requestResponseState=e.getMessage();
        }
		return requestResponseState;
    }
	public HTTPRequest createOauthRequest(){
        HTTPRequest req= new HttpRequest();
        req.setendpoint(QuickBookDetail.OAuthbase_URI__c);
        req.setmethod('POST');
        req.setHeader('Accept', 'application/json');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueof(QuickBookDetail.Client_Id__c+':'+QuickBookDetail.Client_Secret__c)));
        req.setBody(body());
        return req;
    }
	public String body(){
        String tempBody ='';
        if(grant_type=='authorization_code'){
            tempBody = 'grant_type=authorization_code&code='+authorization_code+'&redirect_uri='+QuickBookDetail.Redirect_URI__c;
        }else if(grant_type=='refresh_token'){
            tempBody = 'grant_type=refresh_token&refresh_token='+QuickBookDetail.Refresh_Token__c;
        }
        return tempBody;
    }
	public void updateQuickBookMetaData(){
            Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
            customMetadata.fullName = 'QuickBookDetail__mdt' + '.' + QuickBookDetail.DeveloperName;
            customMetadata.label = QuickBookDetail.DeveloperName;
			System.debug(responseJSON);
        
            customMetadata.values.add(createCustomMetadataField('Access_Token__c',responseJSON.access_token));
            customMetadata.values.add(createCustomMetadataField('Refresh_Token__c',responseJSON.refresh_token));

			QuickBookDetail.Access_Token__c = responseJSON.access_token;

            Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
            mdContainer.addMetadata(customMetadata);
			If(!Test.isRunningTest())
            ID jobId =Metadata.Operations.enqueueDeployment(mdContainer, new QuickBooksHttpWrapper());
    }
    public Metadata.CustomMetadataValue createCustomMetadataField(String field,String fieldValue){
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = field;
        customField.value = fieldValue;
        return customField;
    }

    public void handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context) {
        if (result.status == Metadata.DeployStatus.Succeeded) {
            System.debug('success: '+ result);
        } else {
            System.debug('fail: '+ result);
        }
    }
}