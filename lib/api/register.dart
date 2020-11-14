import 'package:bodytime/api/base_call.dart' as BaseCall;

class RegisterRequest extends BaseCall.BasePostCall<LoginResponse> {
  @override
  String get requestUrl => "auth/register";

  RegisterRequest(String phone) {
    setBody({
      "params": {"phone": phone}
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
