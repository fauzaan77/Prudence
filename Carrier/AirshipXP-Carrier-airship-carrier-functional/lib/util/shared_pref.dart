import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final String AUTH_TOKEN = "AUTH_TOKEN";
  static final String USER_DATA = "USER_DATA";
  static final String IS_LOGGED_IN = "IS_LOGGED_IN";

  SessionManager() {
    init();
  }

  SharedPreferences? prefs;

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

//set data into shared preferences like this

  Future<void> setString(String key, String value) async {
    prefs?.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    prefs?.setInt(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    prefs?.setBool(key, value);
  }

//get value from shared preferences
  Future<String?> getString(String key) async {
    return prefs?.getString(key);
  }

  Future<int?> getInt(String key) async {
    return prefs?.getInt(key);
  }

  Future<bool?> getBool(String key) async {
    return prefs?.getBool(key);
  }
}
