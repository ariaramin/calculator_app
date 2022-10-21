import 'package:calculator/conatants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    Application(),
  );
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  String inputUser = "";
  String result = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        systemNavigationBarColor: backgroundColor,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    inputUser,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: expressionTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    result,
                    style: TextStyle(
                      color: resultTextColor,
                      fontSize: 62,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _getRow(['ac', 'ce', '%', '÷']),
                ),
                Expanded(
                  child: _getRow(['7', '8', '9', '×']),
                ),
                Expanded(
                  child: _getRow(['4', '5', '6', '-']),
                ),
                Expanded(
                  child: _getRow(['1', '2', '3', '+']),
                ),
                Expanded(
                  child: _getRow(['00', '0', '.', '=']),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getRow(List<String> list) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var text in list)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: _getBackgroundColor(text),
                ),
                onPressed: () {
                  if (text == "=") {
                    _calculate();
                  } else if (text == "ac") {
                    setState(() {
                      inputUser = "";
                      result = "";
                    });
                  } else {
                    _setTextToInput(text);
                  }
                },
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _calculate() {
    Parser parser = Parser();
    Expression expression = parser.parse(_getText(inputUser));
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    setState(() {
      result = eval.toString();
    });
  }

  void _setTextToInput(String text) {
    setState(() {
      if (text == "ce") {
        var inputLength = inputUser.length;
        if (inputLength > 0) {
          inputUser = inputUser.substring(0, inputLength - 1);
        }
      } else {
        inputUser = inputUser + text;
      }
    });
  }

  bool _isOperator(String text) {
    var operatorList = ['ce', '%', '÷', '×', '-', '+'];

    for (var item in operatorList) {
      if (text == item) {
        return true;
      }
    }

    return false;
  }

  String _getText(String text) {
    text = text.replaceAll(RegExp(r"×"), "*");
    text = text.replaceAll(RegExp(r"÷"), "/");
    return text;
  }

  Color _getBackgroundColor(String text) {
    if (_isOperator(text)) {
      return operatorButtonColor;
    } else if (text == "ac") {
      return redColor;
    } else if (text == "=") {
      return greenColor;
    } else {
      return buttonColor;
    }
  }
}
