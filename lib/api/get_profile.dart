import 'package:bodytime/api/base_call.dart' as BaseCall;

import '../models/subscriber.dart';

class GetProfile extends BaseCall.BasePostCall<Subscriber> {

  @override
  String get requestUrl => "getList";

  GetProfile() {
    setBody({
      "params": {"collection" : "subscribers"}
    });
  }

  @override
  Subscriber parse(dynamic data) {
    return Subscriber.fromDynamic(data);
  }
}