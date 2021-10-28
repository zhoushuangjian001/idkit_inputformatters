mixin NumeralInputFormatterMixin {
  /// Verify length.
  verifyLength(
    String curValue,
    String oldValue,
    int length,
    Function(String, bool)? call,
  ) {
    final bool res = curValue.length > length;
    final String value = res ? oldValue : curValue;
    call?.call(value, res);
  }

  /// Verify maxvalue.
  verifyMaxValue(
    String curValue,
    String oldValue,
    num maxValue,
    Function(String, bool)? call,
  ) {
    final double? value = double.tryParse(curValue);
    late bool res = false;
    if (value != null) {
      res = value > maxValue;
    }
    final String result = res ? oldValue : curValue;
    call?.call(result, res);
  }

  /// Verify minvalue.
  verifyMinValue(
    String curValue,
    String oldValue,
    num minValue,
    Function(String, bool)? call,
  ) {
    final double? value = double.tryParse(curValue);
    late bool res = false;
    if (value != null) {
      res = value < minValue;
    }
    final String result = res ? oldValue : curValue;
    call?.call(result, res);
  }

  /// Verify range.
  verifyRange(
    String curValue,
    String oldValue,
    num minValue,
    num maxValue,
    Function(String, bool)? call,
  ) {
    final double? value = double.tryParse(curValue);
    late bool res = false;
    if (value != null) {
      res = value < minValue || value > maxValue;
    }
    final String result = res ? oldValue : curValue;
    call?.call(result, res);
  }

  // Maximum decimal place of check data.
  verifyMaximumDecimal(
    String curValue,
    String oldValue,
    int digit,
    Function(String, bool)? call,
  ) {
    late String result = curValue;
    late bool res = false;
    final List<String> resList = curValue.split('.');
    if (resList.length >= 2) {
      if (resList.last.length > digit) {
        result = oldValue;
        res = true;
      }
    }
    call?.call(result, res);
  }
}
