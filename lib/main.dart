import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  String _previousInput = "";
  String _operator = "";

  // Function to handle button presses
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _currentInput = "";
        _previousInput = "";
        _operator = "";
        _output = "0";
      } else if (buttonText == "=") {
        _currentInput = _previousInput + _operator + _currentInput;
        _output = _evaluateExpression(_currentInput);
        _previousInput = _output;
        _operator = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_currentInput.isNotEmpty) {
          _previousInput = _currentInput;
          _operator = buttonText;
          _currentInput = "";
        }
      } else {
        if (_currentInput == "0" && buttonText != ".") {
          _currentInput = buttonText;
        } else {
          _currentInput += buttonText;
        }
      }
      _output = _currentInput;
    });
  }

  // Evaluate expression (simple implementation)
  String _evaluateExpression(String expression) {
    try {
      final parsedExpression =
          expression.replaceAll("x", "*").replaceAll("÷", "/");
      final result = _parseMath(parsedExpression);
      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  // Parse math expressions and calculate result
  double _parseMath(String expression) {
    final components = expression.split(RegExp(r"[\+\-\*/]"));
    int index = 0;
    double result = double.parse(components[index++]);

    for (int i = 0; i < components.length - 1; i++) {
      final operator =
          expression[expression.indexOf(components[i]) + components[i].length];
      double operand = double.parse(components[index++]);
      if (operator == '+') result += operand;
      if (operator == '-') result -= operand;
      if (operator == '*') result *= operand;
      if (operator == '/') result /= operand;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 5, 5),
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("/"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("x"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildButton("C"),
                    _buildButton("0"),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Function to build a calculator button
  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonText == "="
            ? Colors.orange
            : buttonText == "C"
                ? Colors.red
                : Colors.grey[850],
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      onPressed: () => buttonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
