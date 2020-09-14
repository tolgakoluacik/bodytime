import 'package:bodytime/api/base_call.dart' as BaseCall;

class ForgotPasswordWithCodeRequest extends BaseCall.BasePostCall<ForgotPasswordResponse> {
  @override
  String get requestUrl => "auth/verificatePasswordResetCode";

  ForgotPasswordWithCodeRequest(String phone, String verificationCode) {
    setBody({
      "params": {"phone": phone, "verificationCode": verificationCode}
    });
  }

  @override
  ForgotPasswordResponse parse(data) {
    var response = ForgotPasswordResponse();
    response.success = data["success"];
    response.definePasswordToken = data["definePasswordToken"];
    return response;
  }
}

class ForgotPasswordResponse {
  bool success;
  String definePasswordToken;
}
