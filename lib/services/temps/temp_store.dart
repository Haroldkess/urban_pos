import 'package:shared_preferences/shared_preferences.dart';

class TempStore {
  static const tokenKey = "tokenKey";
  static const phoneKey = "phoneKey";
  static const shopIdKey = "shopIdKey";
   static const shopIdNumKey = "shopIdNumKey";
  static const passwordKey = "passwordKey";
  static const isLoggedInKey = "isLoggedInKey";
  static const orderSentKey = "orderSentKey";
  static Future<SharedPreferences> pref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences;
  }

  static Future storeToken(token) async {
    SharedPreferences myPref = await pref();
    await myPref.setString(tokenKey, token);
  }
}
