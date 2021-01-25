import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  static const String jwtKey = 'jwt';
  static void saveJWToken(String jwtToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(jwtKey, jwtToken);
  }

  static Future<String> readJWToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(jwtKey) ?? "";
  }

  static void deleteJWToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(jwtKey);
  }

  static Future<Map<String, String>> getHeaders() async {
    String jwtToken = await SharedPreferenceUtils.readJWToken();
    Map<String, String> headers = {"Authorization": "Bearer " + jwtToken};
    return headers;
  }

  static Future<int> decodeJWT() async {
    Map<String, dynamic> payload = Jwt.parseJwt(jwtKey);
    return int.parse(payload['id']);
  }
}
