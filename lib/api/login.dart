import 'package:bodytime/api/base_call.dart' as BaseCall;

class Login extends BaseCall.BasePostCall<LoginResponse> {

  @override
  String get requestUrl => "TokenAuth/Authenticate";

  Login(String username, String password, String firebaseToken) {
    setBody({
      "userNameOrEmailAddress": username,
      "password": password,
      "rememberClient": true,
      "firebaseToken": firebaseToken,
    });
  }

  @override
  LoginResponse parse(data) {
    var response = LoginResponse();
    response.accessToken = data["result"]["accessToken"];
    response.encryptedAccessToken = data["result"]["encryptedAccessToken"];
    response.expireInSeconds = data["result"]["expireInSeconds"];
    response.userId = data["result"]["userId"];
    return response;
  }
}

class LoginResponse {
  String accessToken;
  String encryptedAccessToken;
  int expireInSeconds;
  int userId;
}