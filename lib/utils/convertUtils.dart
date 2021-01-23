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

  static String formDateTimeToStr(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  static double fromNumberToDouble(dynamic num) {
    if (num == null) return 0.0;
    if (num is double) return num;
    if (num is int) return num.toDouble();
    return num;
  }

  static int fromDynamicToInt(dynamic num) {
    if (num == null) return 0;
    if (num is int) return num;
    if (num is double) return num.toInt();
    if (num is String) return int.parse(num);
  }
}
