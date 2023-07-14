import 'package:calculator/di/di.dart';
import 'package:calculator/theme/theme_provider.dart';
import 'package:calculator/widgets/button_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userInput = '';
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: ChangeNotifierProvider.value(
                value: locator.get<ThemeProvider>(),
                child: Consumer<ThemeProvider>(
                  builder: (context, value, child) {
                    return FlutterSwitch(
                      width: 66,
                      height: 32,
                      toggleSize: 24,
                      activeText: '',
                      inactiveText: '',
                      activeColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      inactiveColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      toggleColor: Theme.of(context).colorScheme.secondary,
                      value: value.isDark,
                      showOnOff: true,
                      onToggle: (val) {
                        value.isDark = val;
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _userInput,
                          style: TextStyle(
                            fontSize: 26,
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(.7),
                          ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          _result,
                          style: TextStyle(
                            fontSize: 38,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Expanded(
                          child: ButtonRow(
                            buttonList: const ['C', '+/-', '%', '÷'],
                            onButtonPressed: (button) =>
                                _handleOnButtonPressed(button),
                          ),
                        ),
                        Expanded(
                          child: ButtonRow(
                            buttonList: const ['7', '8', '9', '×'],
                            onButtonPressed: (button) =>
                                _handleOnButtonPressed(button),
                          ),
                        ),
                        Expanded(
                          child: ButtonRow(
                            buttonList: const ['4', '5', '6', '-'],
                            onButtonPressed: (button) =>
                                _handleOnButtonPressed(button),
                          ),
                        ),
                        Expanded(
                          child: ButtonRow(
                            buttonList: const ['1', '2', '3', '+'],
                            onButtonPressed: (button) =>
                                _handleOnButtonPressed(button),
                          ),
                        ),
                        Expanded(
                          child: ButtonRow(
                            buttonList: const ['.', '0', 'ce', '='],
                            onButtonPressed: (button) =>
                                _handleOnButtonPressed(button),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnButtonPressed(String button) {
    if (button == '=') {
      _calculator();
    } else if (button == 'C') {
      setState(() {
        _userInput = '';
        _result = '';
      });
    } else {
      _setTextToInput(button);
    }
  }

  void _calculator() {
    Parser parser = Parser();
    Expression expression = parser.parse(_convertOperator(_userInput));
    ContextModel contextModel = ContextModel();
    final eval = expression.evaluate(EvaluationType.REAL, contextModel);
    setState(() {
      _result = eval.toString();
    });
  }

  String _convertOperator(String text) {
    text = text.replaceAll(RegExp(r"÷"), '/');
    text = text.replaceAll(RegExp(r"×"), '*');
    return text;
  }

  void _setTextToInput(String text) {
    setState(() {
      if (text == 'ce') {
        final inputLength = _userInput.length;
        if (inputLength > 0) {
          _userInput = _userInput.substring(0, inputLength - 1);
        }
      } else {
        _userInput = _userInput + text;
      }
    });
  }
}
