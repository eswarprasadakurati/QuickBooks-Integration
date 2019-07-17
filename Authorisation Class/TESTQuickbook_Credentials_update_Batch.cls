@isTest 
public class TESTQuickbook_Credentials_update_Batch 
{
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
    @isTest
    public static void testMethod1() 
    {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200, 'success','{"token_type":"bearer","access_token":"eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiZGlyIn0..YTbzTdwfs5VESk-RUgV9Tg.GvVX6LkZzvC27PhmP32_aYPz4HgPOm-beMvHs2GLpwLVmirKsazGEnpK2cporaMucnTRSvyxoZKVzy-Hdc3loTAoA3oRLnBEuh9613wQMHZ-nuapjbodpLrUTLS-17u3YvF5rPJEQNXB1sSlVCeOPucStJgYXkKfF4qbK7mq8ewRN7tmARAZlvWgo7NEK_EHg0qDN3FCCSa0HH9QMAdBtdYVQkRuFiv2rSM0qz6wCollWn92ds0nzbuLtLqjd2bk-4ZjnKpAazn8XDaA_putOpN6wqmGEfUQwP-vtNgb_uSKp8vUi2vpaM_T47MJWx--D8aJ6JdS-GPFyK4vNB82pBMRks6gjt2x1qS_OtgNIvknuTNS2eF9lCbkRNpWkUI1_-SsemFFR8YUe4O7VnjsmDSg2SGNG14mHhvtskk0GjiOjwYdQJjraVvJgHVjZgoRmEj3vFCPWliFL6kilyv-uj5XKepoHX6qeKRpaCWJdHrmtZeJ3kvN1sFDdv8kkKfVn0AJA88HvPlF9LopCJekoXe0Wxlsn6XOWN_JkV5hP76LYGjpOB2GHWqy3BL92qpoGFq3Jbt48fqV0qXk1frdViWTmm5aPvGbygozXNlW4EYelCIWlZTjejKv41XZnuBe6DFRgP0dCqg612LRv2ghH9mIWrDN66lEbkWgIBjDqzZfgRW1ATmNbNjOzk6vMfAybaDZZuWCPkudN_LXEkq-X-ak9ywHiCzbR4jvL_bNe7-hgAWkHEryuW8VgtXtb2wFW7niozF6tcNL8KukGAGpsifuDYH_GvpkpVVjwbOnTnPsyR_yvabbSTwInbUiF3DahH9A1wZmqWcFSahjx8uNzQ.13XN6p-_3uHsdEWzLanCQA","x_refresh_token_expires_in":8726400,"refresh_token":"L011554378373EYhWemhzRr4EBMjugQ9ENpSRx8Dzi7PNmiVXi","expires_in":3600,"id_token":"eyJraWQiOiJPUElDUFJEMDkxODIwMTQiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI5Nzk1OTZlNy02MmI5LTQ5N2ItODQwMy03M2MyZDdkYmMzOTMiLCJhdWQiOlsiUTBxcENsdVZuMTluanREaGE4UnJ6SUxQZ0JPdlBhU2ZVZXdOQ1l6VFB4Y2p2REljRWQiXSwicmVhbG1pZCI6IjEyMzE0NjIxNzM4MzU4OSIsImF1dGhfdGltZSI6MTU0NTY1MTc2NiwiaXNzIjoiaHR0cHM6XC9cL29hdXRoLnBsYXRmb3JtLmludHVpdC5jb21cL29wXC92MSIsImV4cCI6MTU0NTY1NTU3MywiaWF0IjoxNTQ1NjUxOTczfQ.RPvxBA89WGu4QFr6UjIkTITPsaZZRj0fZNC9j8_KVFYCIk9VYMm8b_e6ASFeZ3njxf9D4r0y23ARg1E5l1jHinmlHLbiZmIZqhr0FXBfV69vyt9F8TRztHF0gOP5VwDqpIL7T461_3s7PyC73XR0SUeeCB7EwrIhzIRqo05sm1Q"}'
								,new map<string,string>() ));
               
        QucikBooksRedirectPage_ctrl qbrp=new QucikBooksRedirectPage_ctrl();
        qbrp.requestResponseState='test';
        qbrp.newAccessToken(); 
        qbrp.newRefreshToken();
        new QucikbookAuth_Ctrl().getOAuth();
        
		String sch = '20 30 8 10 2 ?';
		String jobID = system.schedule('Merge Job', sch, new quickbook_Credentials_update_Sch());
        System.scheduleBatch(new Quickbook_Credentials_update_Batch(),'test2',1);
        Test.stopTest();
    }   
}