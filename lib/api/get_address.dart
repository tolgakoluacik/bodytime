import 'package:bodytime/api/base_call.dart' as BaseCall;
import 'package:bodytime/models/address.dart';

class GetAddress extends BaseCall.BasePostCall<List<Address>> {

  @override
  String get requestUrl => "GetAddress";

  GetAddress(String zipCode, String houseNumber, {String houseLetter = "", String houseNumberAddition = "", String houseNumberIndication = ""}) {
    body.putIfAbsent("postCode", () => zipCode);
    body.putIfAbsent("houseNumber", () => houseNumber);
    if (houseLetter != null) body.putIfAbsent("houseLetter", () => houseLetter);
    if (houseNumberAddition != null) body.putIfAbsent("houseNumberAddition", () => houseNumberAddition);
    if (houseNumberIndication != null) body.putIfAbsent("houseNumberIndication", () => houseNumberIndication);
  }

  @override
  List<Address> parse(dynamic data) {
    return data.map((item) => Address.fromDynamic(item)).toList();
  }
}