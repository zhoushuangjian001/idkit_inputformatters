import 'package:flutter/foundation.dart';

/// Input exception prompt.
class InputFormatterError {
  const InputFormatterError({
    this.code,
    this.msg,
  });

  final int? code;
  final String? msg;

  /// A brief description of the class.
  String toString() {
    return 'InputFormatterError:code="$code",msg="$msg"';
  }

  /// The input value does not meet the specifications.
  factory InputFormatterError.error() => InputFormatterError(
        code: 0,
        msg: 'The input value does not meet the rules.',
      );

  /// The length of the input value exceeds the maximum length set.
  factory InputFormatterError.maxLength() => InputFormatterError(
        code: 1,
        msg:
            'The length of the input value is greater than the maximum length set.',
      );

  /// The input value exceeds the set maximum value.
  factory InputFormatterError.maxValue() => InputFormatterError(
        code: 2,
        msg:
            'The value of the input value is greater than the maximum value set.',
      );

  /// The input value is less than the set minimum value.
  factory InputFormatterError.minValue() => InputFormatterError(
        code: 3,
        msg: 'The value of the input value is less than the set minimum value.',
      );

  /// The input value is not within the setting range.
  factory InputFormatterError.range() => InputFormatterError(
        code: 4,
        msg: 'The value of the entered value is not within the set range.',
      );

  /// Formatter to keep the number of decimal places in the input value.
  factory InputFormatterError.decimal() => InputFormatterError(
        code: 5,
        msg: 'The decimal place of the input value exceeds the set number.',
      );
}
