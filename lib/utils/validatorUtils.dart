class ValidatorUtils {
  static bool isEmpty(String value) {
    value = value.trim();
    return value.isEmpty;
  }

  static bool isInteger(String value) {
    double doubleValue = double.parse(value);
    return doubleValue is int || doubleValue == doubleValue.roundToDouble();
  }

  static bool isNegativeNumber(String value) {
    double doubleValue = double.parse(value);
    return doubleValue < 0;
  }
}
