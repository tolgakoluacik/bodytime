import 'package:bodytime/api/base_call.dart' as BaseCall;

class VerificationRequest extends BaseCall.BasePostCall<LoginResponse> {
  @override
  String get requestUrl => "auth/verificatePhoneNumber";

  VerificationRequest(String phone, String verificationCode) {
    setBody({
      "params": {"phone": phone, "verificationCode": verificationCode}
    });
  }

  @override
  LoginResponse parse(data) {
    var response = LoginResponse();
    response.success = data["success"];
    response.definePasswordToken = data["definePasswordToken"];
    return response;
  }
}

class LoginResponse {
  bool success;
  String definePasswordToken;
}
