import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idkit_inputformatters/idkit_inputformatters.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamController<InputFormatterError> streamController =
      StreamController();

  @override
  void initState() {
    // Handling of broadcast monitoring events for abnormal input values.
    streamController.stream.listen((event) {
      print(event);
      // Your codes...
    });
    super.initState();
  }

  @override
  void dispose() {
    // Destroy of control objects.
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IDKitInputFormatters package test'),
      ),
      body: Container(
        child: TextField(
          controller: TextEditingController(),
          inputFormatters: [
            // // Only limit the input is the number.
            IDKitNumeralTextInputFormatter(
              minValue: 1,
            ),

            // Limit the maximum length of the input value.
            // IDKitNumeralTextInputFormatter.length(
            //   maxLength: 10,
            //   errorStreamController: streamController,
            // ),

            // Limit the maximum value of the input value.
            IDKitNumeralTextInputFormatter.max(
              maxValue: 100,
              maxDecimalDigit: 2,
              decimalPoint: true,
              errorStreamController: streamController,
            ),

            // Limit the minimum value of the input value.
            IDKitNumeralTextInputFormatter.min(
              minValue: 1,
              maxDecimalDigit: 2,
              decimalPoint: true,
              errorStreamController: streamController,
            ),

            // Limit the range of input values.
            IDKitNumeralTextInputFormatter.range(
              minValue: 2,
              maxValue: 100,
              maxDecimalDigit: 2,
              decimalPoint: false,
              errorStreamController: streamController,
            ),
          ],
        ),
      ),
    );
  }
}
