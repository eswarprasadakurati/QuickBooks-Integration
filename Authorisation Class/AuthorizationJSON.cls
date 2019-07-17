global class AuthorizationJSON {

  global String token_type;
  global Integer x_refresh_token_expires_in;
  global String refresh_token;
  global String access_token;
  global Integer expires_in;

  
  global static AuthorizationJSON parse(String json) {
    return (AuthorizationJSON) System.JSON.deserialize(json, AuthorizationJSON.class);
  }
}