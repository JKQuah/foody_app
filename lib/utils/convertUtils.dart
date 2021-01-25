import 'package:intl/intl.dart';

class ConvertUtils {
  static DateTime fromIsoStrToDateTime(String isoString) {
    if (isoString == null) return null;
    return DateTime.parse(isoString);
  }

  static String fromDateTimeToDateStr(DateTime dateTime) {
    if (dateTime == null) return "";
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String fromDateTimeToTimeStr(DateTime dateTime) {
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dateTime);
  }

  static double convertInttoDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    }
  }

  static DateTime convertStringToDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.parse(value);
    }
  }

  static String convertStringToBase64String(dynamic value) {
    return "data:image/jpeg;base64," + value;
  }

}
