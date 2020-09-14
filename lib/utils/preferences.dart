import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static Storage _storageUtil;
  static SharedPreferences _preferences;

  static Future getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = Storage._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  Storage._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defValue}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  static Future putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value);
  }

  static int getInt(String key, {int defValue}) {
    if (_preferences == null) return defValue;
    return int.tryParse(_preferences.getString(key)) ?? defValue;
  }

  static Future putInt(String key, int value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, "${value}");
  }

  static double getDouble(String key, {double defValue}) {
    if (_preferences == null) return defValue;
    return double.tryParse(_preferences.getString(key)) ?? defValue;
  }

  static Future putDouble(String key, double value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, "${value}");
  }

  static bool getBoolean(String key, {bool defValue}) {
    if (_preferences == null) return defValue;
    var strVal = _preferences.getString(key);
    return strVal == null ? defValue : (strVal == "true");
  }

  static Future putBoolean(String key, bool value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value ? "true" : "false");
  }
}