public class QucikbookAuth_Ctrl {
    public pagereference  getOAuth(){
        QuickBookDetail__mdt QuickBookDetail = [SELECT Id,base_URI__c, DeveloperName, MasterLabel, Language, NamespacePrefix, Label, QualifiedApiName, Client_Secret__c, Client_Id__c, Refresh_Token__c, Scopes__c, Authorization_Code__c, Company_ID__c, Access_Token__c, Redirect_URI__c, OAuthbase_URI__c FROM QuickBookDetail__mdt where DeveloperName='quickbook' limit 1];
        String quickbookEndURL =QuickBookDetail.base_URI__c+'?client_id='+QuickBookDetail.Client_Id__c+'&scope='+QuickBookDetail.Scopes__c+'&redirect_uri='+QuickBookDetail.Redirect_URI__c+'&response_type=code&state=eswar';
        return new pagereference(quickbookEndURL);
    }
}