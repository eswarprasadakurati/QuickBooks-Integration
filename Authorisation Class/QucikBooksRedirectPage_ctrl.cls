public class QucikBooksRedirectPage_ctrl{
    public String requestResponseState{get;set;}
    public void newRefreshToken(){
        QuickBooksHttpWrapper QuickBooksHttpWrapperObj = new QuickBooksHttpWrapper();
        QuickBooksHttpWrapper.grant_type ='authorization_code';
        QuickBooksHttpWrapper.authorization_code = ApexPages.currentPage().getParameters().get('code');
        requestResponseState=QuickBooksHttpWrapperObj.makeOauthHTTPRequest();
        System.debug(requestResponseState);
        QuickBooksHttpWrapperObj.updateQuickBookMetaData(/*QuickBooksHttpWrapper.responseJSON*/);
    }
    public void newAccessToken(){
        QuickBooksHttpWrapper QuickBooksHttpWrapperObj = new QuickBooksHttpWrapper();
        QuickBooksHttpWrapper.grant_type ='refresh_token';
        requestResponseState=QuickBooksHttpWrapperObj.makeOauthHTTPRequest();
        QuickBooksHttpWrapperObj.updateQuickBookMetaData(/*QuickBooksHttpWrapper.responseJSON*/);
    }
   }