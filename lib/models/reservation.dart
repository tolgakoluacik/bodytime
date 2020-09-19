class Reservation {

  String id;
  String service;
  DateTime date;
  String subscriberId;
  String subscriberName;
  String instructor;
  String notes;
  String branch;
  DateTime createdAt;

  static Reservation fromDynamic(dynamic obj) {
    Reservation reservation = new Reservation();

    reservation.id = obj["_id"];
    reservation.service = obj["service"];
    reservation.date = obj["date"] == null ? null : DateTime.parse(obj["date"]);
    reservation.subscriberId = obj["subscriberId"];
    reservation.subscriberName = obj["subscriberName"];
    reservation.instructor = obj["instructor"];
    reservation.notes = obj["notes"];
    reservation.branch = obj["branch"];
    reservation.createdAt = obj["createdAt"] == null ? null : DateTime.parse(obj["createdAt"]);

    return reservation;
  }
}