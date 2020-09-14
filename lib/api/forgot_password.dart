import 'package:bodytime/api/base_call.dart' as BaseCall;

class ForgotPasswordRequest extends BaseCall.BasePostCall<ForgotPasswordResponse> {
  @override
  String get requestUrl => "auth/forgotPassword";

  ForgotPasswordRequest(String phone) {
    setBody({
      "params": {"phone": phone}
    });
  }

  @override
  ForgotPasswordResponse parse(data) {
    var response = ForgotPasswordResponse();
    response.success = data["success"];
    return response;
  }
}

class ForgotPasswordResponse {
  bool success;
}
