import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConvertUtils {
  static double convertInttoDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  static DateTime convertStringToDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.parse(value);
    }
    return value;
  }

  static String convertStringToBase64String(dynamic value) {
    return "data:image/jpeg;base64," + value;
  }

  static double convertNumberToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return value;
  }

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

  static Future<String> fromPickedFileToBase64Url(PickedFile file) async {
    Uint8List bytes = await file.readAsBytes();
    String base64Content = base64Encode(bytes);
    String fileExtension = file.path.endsWith("png") ? "png" : "jpeg";
    // data:image/jpeg;base64, base64Content
    return "data:image/${fileExtension};base64,${base64Content}";
  }

  static Future<Uint8List> fromBase64UrlToUint8List(String base64Url) async {
    String base64Content =
        base64Url.replaceAll(new RegExp(r"^(.+)base64,"), "");
    Uint8List bytes = base64Decode(base64Content);
    return bytes;
  }
}
