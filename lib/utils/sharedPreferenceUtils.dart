import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SharedPreferenceUtils {
  static const String jwtKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI0IiwiaWF0IjoxNjExNTYxMTY2LCJleHAiOjE2MTE2NDc1NjZ9.vtG7OCOCcAEKfuYd8gZnW_eMfpwWb6YSTZqfFfkx6ts';
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
