import 'package:bodytime/api/base_call.dart' as BaseCall;
import 'package:bodytime/models/reservation.dart';

class GetReservations extends BaseCall.BasePostCall<List<Reservation>> {

  @override
  String get requestUrl => "getList";

  GetReservations() {
    setBody({
      "params": {"collection" : "reservations", "sort":{"date" : 1}
      }
    });
  }

  @override
  List<Reservation> parse(dynamic data) {

    List<Reservation> resList = [];

    for (var dynRes in data) {
      resList.add(Reservation.fromDynamic(dynRes));
    }

    return resList;
  }
}