class Instructor {

  String id = "";
  String about = "";
  String name = "";
  String phone = "";
  bool isPhoneVerified = false;
  DateTime birthYear = null;
  String branch = "";
  String cardNo = "";
  String gender = "";
  String instructor = "";
  String community = "";
  String addressType = "";

  static Instructor fromDynamic(dynamic obj) {
    Instructor subscriber = new Instructor();

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

    return subscriber;
  }
}