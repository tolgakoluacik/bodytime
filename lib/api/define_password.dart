import 'package:bodytime/api/base_call.dart' as BaseCall;
class DefinePasswordRequest extends BaseCall.BasePostCall<LoginResponse> {
  @override
  String get requestUrl => "auth/definePassword";

  DefinePasswordRequest(String phone, String password, String definePasswordToken) {
    setBody({
      "params": {
        "phone": phone,
        "password": password,
        "token": definePasswordToken,
      }
    });
  }

  @override
  LoginResponse parse(data) {
    var response = LoginResponse();
    response.success = data["success"];
    return response;
  }
}

class LoginResponse {
  bool success;
}
