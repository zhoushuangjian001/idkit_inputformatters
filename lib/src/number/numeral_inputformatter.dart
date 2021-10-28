import 'dart:async' show StreamController;
import 'package:flutter/services.dart'
    show TextInputFormatter, TextEditingValue, TextSelection;
import 'package:idkit_inputformatters/src/number/numeral_extension.dart';
import 'package:idkit_inputformatters/src/number/numeral_inputformatter_error.dart';

/// Text number input formatter.
class IDKitNumeralTextInputFormatter extends TextInputFormatter
    with NumeralInputFormatterMixin {
  IDKitNumeralTextInputFormatter({
    this.maxValue,
    this.minValue,
    this.maxLength,
    this.maxDecimalDigit,
    this.decimalPoint = true,
    NumeralFormatterType formatterType = NumeralFormatterType.none,
    this.errorStreamController,
  })  : _formatterType = formatterType,
        assert(maxLength == null || maxDecimalDigit == null,
            'The [maxLength] attribute cannot exist at the same time as [maxDecimalDigit] attribute'),
        assert(minValue != null && minValue < 9,
            'The minimum value of the input value must be less than 9.');

  /// The maximum value that can be entered.
  num? maxValue;

  /// The minimum value that can be entered.
  num? minValue;

  /// The maximum length of the maximum value that can be entered.
  int? maxLength;

  /// Maximum number of decimal places that can be entered.
  int? maxDecimalDigit;

  /// Whether the decimal point is available. Default true.
  bool decimalPoint;

  /// Enter the control object of the abnormal event.
  StreamController<InputFormatterError>? errorStreamController;

  // Default number formatting type.
  late NumeralFormatterType _formatterType = NumeralFormatterType.none;

  /// Limit the maximum length of the input value.
  ///
  /// [maxLength] Restricted maxLength.
  /// [errorStreamController] Enter the control object of the abnormal event.
  IDKitNumeralTextInputFormatter.length({
    required this.maxLength,
    this.errorStreamController,
  })  : _formatterType = NumeralFormatterType.length,
        decimalPoint = false;

  /// Limit the maximum value of the input value.
  ///
  /// [maxValue] Limit the maximum value entered.
  /// [maxDecimalDigit] Maximum decimal places.
  /// [decimalPoint] Whether the decimal point is available.
  /// [errorStreamController] Enter the control object of the abnormal event.
  IDKitNumeralTextInputFormatter.max({
    required this.maxValue,
    this.maxDecimalDigit,
    this.decimalPoint = true,
    this.errorStreamController,
  }) : _formatterType = NumeralFormatterType.max;

  /// Limit the minimum value of the input value.
  ///
  /// [minValue] Limit the minimum value entered.
  /// [maxDecimalDigit] Maximum decimal places.
  /// [decimalPoint] Whether the decimal point is available.
  /// [errorStreamController] Enter the control object of the abnormal event.
  IDKitNumeralTextInputFormatter.min({
    required this.minValue,
    this.maxDecimalDigit,
    this.decimalPoint = true,
    this.errorStreamController,
  })  : _formatterType = NumeralFormatterType.min,
        assert(minValue! < 9,
            'The minimum value of the input value must be less than 9.');

  /// Limit the range of input values.
  ///
  /// [minValue] Limit the minimum value entered.
  /// [maxValue] Limit the maximum value entered.
  /// [maxDecimalDigit] Maximum decimal places.
  /// [decimalPoint] Whether the decimal point is available.
  /// [errorStreamController] Enter the control object of the abnormal event.
  IDKitNumeralTextInputFormatter.range({
    required this.minValue,
    required this.maxValue,
    this.maxDecimalDigit,
    this.decimalPoint = true,
    this.errorStreamController,
  })  : _formatterType = NumeralFormatterType.range,
        assert(minValue! < 9,
            'The minimum value of the input value must be less than 9.');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Determine whether the input is legal.
    final RegExp regExp =
        decimalPoint ? RegExp(r'^(\d+\.?\d*)?$') : RegExp(r'^(\d*)?$');
    String newText = newValue.text;
    late int selectionIndex = newValue.selection.end;
    final int oldSelectionIndex = oldValue.selection.end;
    if (newText.isNotEmpty) {
      if (!regExp.hasMatch(newText)) {
        selectionIndex = oldSelectionIndex;
        errorStreamController?.add(InputFormatterError.error());
        return oldValue;
      }
      // Filter numbers starting with 00.
      if (newText.startsWith(RegExp(r'0\d'))) {
        selectionIndex = oldSelectionIndex;
        errorStreamController?.add(InputFormatterError.error());
        return oldValue;
      }
    }
    // According to different rules.
    final String oldText = oldValue.text;
    switch (_formatterType) {
      case NumeralFormatterType.length:
        verifyLength(newText, oldValue.text, maxLength!, (value, state) {
          newText = value;
          if (state) {
            selectionIndex = oldSelectionIndex;
            errorStreamController?.add(InputFormatterError.maxLength());
          }
        });
        break;
      case NumeralFormatterType.max:
        verifyMaxValue(newText, oldText, maxValue!, (value, state) {
          newText = value;
          if (state) {
            selectionIndex = oldSelectionIndex;
            errorStreamController?.add(InputFormatterError.maxValue());
          }
        });

        break;
      case NumeralFormatterType.min:
        verifyMinValue(newText, oldText, minValue!, (value, state) {
          newText = value;
          if (state) {
            selectionIndex = oldSelectionIndex;
            errorStreamController?.add(InputFormatterError.minValue());
          }
        });
        break;
      case NumeralFormatterType.range:
        verifyRange(newText, oldText, minValue!, maxValue!, (value, state) {
          newText = value;
          if (state) {
            selectionIndex = oldSelectionIndex;
            errorStreamController?.add(InputFormatterError.range());
          }
        });
        break;
      default:
        // Length check.
        if (maxLength != null) {
          verifyLength(newText, oldValue.text, maxLength!, (value, state) {
            newText = value;
            if (state) {
              selectionIndex = oldSelectionIndex;
              errorStreamController?.add(InputFormatterError.maxLength());
            }
          });
        }

        // Maximum value check.
        if (maxValue != null) {
          verifyMaxValue(newText, oldText, maxValue!, (value, state) {
            newText = value;
            if (state) {
              selectionIndex = oldSelectionIndex;
              errorStreamController?.add(InputFormatterError.maxValue());
            }
          });
        }

        // Minimum value check.
        if (minValue != null) {
          verifyMinValue(newText, oldText, minValue!, (value, state) {
            newText = value;
            if (state) {
              selectionIndex = oldSelectionIndex;
              errorStreamController?.add(InputFormatterError.minValue());
            }
          });
        }

        // Range check check
        if (minValue != null && maxValue != null) {
          verifyRange(newText, oldText, minValue!, maxValue!, (value, state) {
            newText = value;
            if (state) {
              selectionIndex = oldSelectionIndex;
              errorStreamController?.add(InputFormatterError.range());
            }
          });
        }
    }
    // Maximum decimal place of check data.
    if (maxDecimalDigit != null && decimalPoint) {
      verifyMaximumDecimal(newText, oldText, maxDecimalDigit!, (value, state) {
        newText = value;
        if (state) {
          selectionIndex = oldSelectionIndex;
          errorStreamController?.add(InputFormatterError.decimal());
        }
      });
    }

    // Return result.
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/// Number formatting type.
enum NumeralFormatterType {
  length,
  max,
  min,
  range,
  none,
}
