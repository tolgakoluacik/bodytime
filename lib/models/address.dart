class Address {

  String unique = "";
  String street = "";
  String city = "";
  String houseNumber = "";
  String houseLetter = "";
  String houseNumberIndication = "";
  String houseNumberAddition = "";
  String zipCode = "";
  String community = "";
  String addressType = "";

  static Address fromDynamic(dynamic obj) {
    Address address = new Address();

    address.unique = obj["UniqueId"];
    address.street = obj["Street"];
    address.city = obj["City"];
    address.houseNumber = obj["HouseNumber"];
    address.houseLetter = obj["HouseLetter"];
    address.houseNumberIndication = obj["HouseNumberIndication"];
    address.houseNumberAddition = obj["HouseNumberAddition"];
    address.zipCode = obj["ZipCode"];
    address.community = obj["Community"];
    address.addressType = obj["AddressType"];

    return address;
  }
}