import 'package:bodytime/api/base_call.dart' as BaseCall;
import 'package:bodytime/models/subscriber.dart';

class LoginRequest extends BaseCall.BasePostCall<LoginResponse> {
  @override
  String get requestUrl => "auth/login";

  LoginRequest(String phone, String password) {
    setBody({
      "params": {"phone": phone, "password": password}
    });
  }

  @override
  LoginResponse parse(data) {
    var response = LoginResponse();
    response.token = data["token"];
    response.subscriber =
        Subscriber.fromDynamic(data["subscriberObj"]);
    return response;
  }
}

class LoginResponse {
  String token;
  Subscriber subscriber;
}