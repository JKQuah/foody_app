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
}
