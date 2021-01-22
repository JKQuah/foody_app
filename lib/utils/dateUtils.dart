import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateUtils {
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
}
