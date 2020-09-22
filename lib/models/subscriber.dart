class Subscriber {

  String id;
  String about;
  String name;
  String phone;
  bool isPhoneVerified;
  String birthYear = "";
  String branch = "";
  String cardNo = "";
  String gender = "";
  String instructor = "";
  String measure = "";

  static Subscriber fromDynamic(dynamic obj) {
    Subscriber subscriber = new Subscriber();

    subscriber.id = obj["_id"];
    subscriber.about = obj["about"];
    subscriber.name = obj["name"];
    subscriber.phone = obj["phone"];
    subscriber.isPhoneVerified = obj["isPhoneVerified"];
    subscriber.birthYear = obj["birthYear"];
    subscriber.branch = obj["branch"];
    subscriber.cardNo = obj["cardNo"];
    subscriber.gender = obj["gender"];
    subscriber.instructor = obj["instructor"];
    subscriber.measure = obj["measure"];

    return subscriber;
  }
}