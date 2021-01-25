import 'package:shared_preferences/shared_preferences.dart';

class HTTPUtils {

  static const String jwtKey = 'jwt';

  static void saveJWToken(String jwtToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(jwtKey, jwtToken);
  }

  static Future<String> readJWToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(jwtKey) ?? "";
  }

  static void removeJWToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(jwtKey);
  }

  static Future<Map<String, String>> getHeaders() async {
    String jwtToken = await readJWToken();
    Map<String, String> headers = {"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI0IiwiaWF0IjoxNjExNTYxMTY2LCJleHAiOjE2MTE2NDc1NjZ9.vtG7OCOCcAEKfuYd8gZnW_eMfpwWb6YSTZqfFfkx6ts" };

    return headers;
  }

}