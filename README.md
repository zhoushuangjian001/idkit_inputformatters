# idkit_inputformatters

Provide text input formatter. The package is simple to use, powerful, stable, and highly customized. Every developer is welcome to use it.

# Introduction to existing functions

The following is a brief introduction to the existing functions. For more functions and usage, please check the **main.dart** file of **example**.

1. ##### The maximum length of the input box.

   - Example code

     ```dart
     inputFormatters: [
         IDKitNumeralTextInputFormatter.length(
            maxLength: 10,
            errorStreamController: streamController,
         )
     ]
     ```

   - Code explanation
     The above formatter limits the maximum length of the text input value to ten.

2. ##### Limit the maximum value of text input.

   - Example code

     ```dart
     inputFormatters: [
         IDKitNumeralTextInputFormatter.max(
            maxValue: 100,
            maxDecimalDigit: 2,
            decimalPoint: true,
            errorStreamController: streamController,
         ),
     ]
     ```

   - Code explanation
     The above code limits the maximum value of text input to one hundred, and when it is a decimal, the maximum number of digits that can be reserved is two.

3. ##### Limit the minimum value of the text input value, the minimum value cannot be greater than nine.

   - Example code

     ```dart
     inputFormatters: [
         IDKitNumeralTextInputFormatter.min(
            minValue: 1,
            maxDecimalDigit: 2,
            decimalPoint: true,
            errorStreamController: streamController,
         )
     ]
     ```

   - Code explanation
     The above code restricts the minimum value of text input to one, and it can keep up to two decimal places when it is a decimal.

4. ##### Limit the range of text input values, the minimum value cannot be greater than nine.

   - Example code

     ```dart
     inputFormatters: [
         IDKitNumeralTextInputFormatter.range(
            minValue: 2,
            maxValue: 100,
            maxDecimalDigit: 2,
            decimalPoint: false,
            errorStreamController: streamController,
         ),
     ]
     ```

   - Code explanation
     The above code is to limit the input minimum value to two and the maximum value to one hundred. If the input value is a decimal, the maximum number of decimals is two digits.

5. ##### Customizable input formatter.

   - Example code

     ```dart
     inputFormatters: [
         IDKitNumeralTextInputFormatter(...),
     ]
     ```

   - Code explanation
     The above code is the setting of the customizable input formatter.
