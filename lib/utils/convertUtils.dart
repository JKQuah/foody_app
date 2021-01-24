class ConvertUtils {
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
