import 'package:flutter/material.dart';
import 'package:flutter_basic_calculator/components/keypadKeys.dart';
import 'package:math_expressions/math_expressions.dart';

import '../constants.dart';

class MainCal extends StatefulWidget {
  @override
  _MainCalState createState() => _MainCalState();
}

class _MainCalState extends State<MainCal> {
  String result = "";
  String equation = "0";
  String expression = '';
  bool reset = false;
  bool showingResult = false;
  bool editEquation = false;
  String invalid = '❗ Invalid Syntax';
  List symbols = ['+', '-', '%', '×', '÷'];

  void calculation(String switchKey) {
    setState(() {
      if (reset) {
        equation = '';
      }
//     Reset(C) button Function

      if (switchKey == "C") {
        reset = false;
        showingResult = false;
        result = '';
        equation = '0';
      }
//        *******Reset(C)********

//       BackSpace(⌫) Button Function

      else if (switchKey == '⌫') {
        if (switchKey == '⌫' &&
            result.isNotEmpty &&
            result != invalid &&
            reset == true) {
          equation = result;
        }
        reset = false;
        showingResult = false;
        if (equation == result && editEquation == false) {
          equation += ' ';
          equation = equation.substring(0, equation.length - 1);
          editEquation = true;
        } else if (equation.length > 1) {
          equation = equation.substring(0, equation.length - 1);
          editEquation = false;
        } else {
          equation = '0';
          result = '';
        }
      }
//        *******BackSpace(⌫)********

//        EqualTo(=) Button Function

      else if (switchKey == '=') {
        showingResult = true;
        reset = true;
        if (result == invalid || result == '0' || equation == '0') {
          result = '';
          equation = '0';
          showingResult = false;
          reset = false;
        } else {
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          try {
            if (expression.isEmpty) {
              expression = result;
              equation = result;
            }
//            Evaluating Result

            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            var tempResult = exp.evaluate(EvaluationType.REAL, cm).toString();
            if (tempResult.split('.')[1] == '0') {
              result = tempResult.split('.')[0].toString();
            } else {
              tempResult = double.parse(tempResult).toStringAsFixed(3);
              result = tempResult.toString();
            }
          } catch (e) {
            print(e);
            result = invalid;
          }
        }
      }
//          ************Evaluation**************

//        ********EqualTo(=)********

//      Answer(ANS) Button Function

      else if (switchKey == 'ANS') {
        if (result.isNotEmpty && result != invalid) {
          equation = result;
        } else {
          equation = '0';
          result = '';
        }
        showingResult = false;
      }

//      *******ANS********

//      Other Buttons

      else {
        equation.startsWith('0') ? equation = '' : equation = equation;

//        Operators(+,-,%,x,÷)

        if ((switchKey == '+' ||
            switchKey == '-' ||
            switchKey == '%' ||
            switchKey == '×' ||
            switchKey == '÷')) {
          if ((switchKey == '+' ||
              switchKey == '-' ||
              switchKey == '%' ||
              switchKey == '×' ||
              switchKey == '÷') &&
              result.isNotEmpty &&
              result != invalid &&
              reset == true) {
            equation = result;
            equation += switchKey;
          } else if (result == invalid) {
            result = '';
          } else {
            if (equation != '0' &&
                !symbols.contains(equation[equation.length - 1])) {
              equation += switchKey;
            } else {
              equation = equation;
            }
          }
          reset = false;
          showingResult = false;
        }

//        ***********Operators********

//        Numbers

        else {
          equation += switchKey;
          reset = false;
          showingResult = false;
        }

//        ********Numbers**********
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return media.orientation == Orientation.portrait
        ? Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.centerRight,
                child: Text(
                  result.isNotEmpty && result != invalid
                      ? '= $result'
                      : result,
                  style: result != invalid
                      ? TextStyle(fontSize: showingResult ? 50.0 : 25.0)
                      : TextStyle(fontSize: showingResult ? 30.0 : 20.0),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.centerRight,
                child: Text(
                  equation,
                  style: TextStyle(fontSize: showingResult ? 25.0 : 50.0),
                ),
              ),
              Divider(),
            ],
          ),
        ),
        Container(
          child: Table(
            children: [
              TableRow(
                children: [
                  KeypadKeys(
                    text: 'C',
                    color: kSplColor,
                    onPressed: () => calculation("C"),
                  ),
                  KeypadKeys(
                    text: '⌫',
                    color: kSplColor,
                    onPressed: () => calculation('⌫'),
                  ),
                  KeypadKeys(
                    text: '%',
                    color: kSplColor,
                    onPressed: () => calculation('%'),
                  ),
                  KeypadKeys(
                    text: '÷',
                    color: kSplColor,
                    onPressed: () => calculation('÷'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  KeypadKeys(
                    text: '7',
                    onPressed: () => calculation('7'),
                  ),
                  KeypadKeys(
                    text: '8',
                    onPressed: () => calculation('8'),
                  ),
                  KeypadKeys(
                    text: '9',
                    onPressed: () => calculation('9'),
                  ),
                  KeypadKeys(
                    text: '×',
                    color: kSplColor,
                    onPressed: () => calculation('×'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  KeypadKeys(
                    text: '4',
                    onPressed: () => calculation('4'),
                  ),
                  KeypadKeys(
                    text: '5',
                    onPressed: () => calculation('5'),
                  ),
                  KeypadKeys(
                    text: '6',
                    onPressed: () => calculation('6'),
                  ),
                  KeypadKeys(
                    text: '-',
                    color: kSplColor,
                    onPressed: () => calculation('-'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  KeypadKeys(
                    text: '1',
                    onPressed: () => calculation('1'),
                  ),
                  KeypadKeys(
                    text: '2',
                    onPressed: () => calculation('2'),
                  ),
                  KeypadKeys(
                    text: '3',
                    onPressed: () => calculation('3'),
                  ),
                  KeypadKeys(
                    text: '+',
                    color: kSplColor,
                    onPressed: () => calculation('+'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  KeypadKeys(
                    text: 'ANS',
                    onPressed: () => calculation('ANS'),
                    color: kSplColor,
                  ),
                  KeypadKeys(
                    text: '0',
                    onPressed: () => calculation('0'),
                  ),
                  KeypadKeys(
                    text: '.',
                    onPressed: () => calculation('.'),
                  ),
                  KeypadKeys(
                    text: '=',
                    color: kSplColor,
                    circle: true,
                    onPressed: () => calculation('='),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    )
        : Column(
      children: <Widget>[
        Container(
          height: media.size.height * 0.1,
          padding: EdgeInsets.fromLTRB(2, 2, 8, 2),
          alignment: Alignment.centerRight,
          child: Text(
            result.isNotEmpty && result != invalid ? '= $result' : result,
            style: result != invalid
                ? TextStyle(fontSize: showingResult ? 30.0 : 20.0)
                : TextStyle(fontSize: showingResult ? 30.0 : 20.0),
          ),
        ),
        Divider(),
        Container(
          height: media.size.height * 0.1,
          padding: EdgeInsets.fromLTRB(2, 2, 8, 2),
          alignment: Alignment.centerRight,
          child: Text(
            equation,
            style: TextStyle(fontSize: showingResult ? 20.0 : 30.0),
          ),
        ),
        Divider(),
        Container(
          height: media.size.height / 3,
          child: Table(
            children: [
              TableRow(
                children: [
                  LandscapeKeypadKeys(
                    text: 'C',
                    color: kSplColor,
                    onPressed: () => calculation("C"),
                  ),
                  LandscapeKeypadKeys(
                    text: '⌫',
                    color: kSplColor,
                    onPressed: () => calculation('⌫'),
                  ),
                  LandscapeKeypadKeys(
                    text: '%',
                    color: kSplColor,
                    onPressed: () => calculation('%'),
                  ),
                  LandscapeKeypadKeys(
                    text: '÷',
                    color: kSplColor,
                    onPressed: () => calculation('÷'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  LandscapeKeypadKeys(
                    text: '7',
                    onPressed: () => calculation('7'),
                  ),
                  LandscapeKeypadKeys(
                    text: '8',
                    onPressed: () => calculation('8'),
                  ),
                  LandscapeKeypadKeys(
                    text: '9',
                    onPressed: () => calculation('9'),
                  ),
                  LandscapeKeypadKeys(
                    text: '×',
                    color: kSplColor,
                    onPressed: () => calculation('×'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  LandscapeKeypadKeys(
                    text: '4',
                    onPressed: () => calculation('4'),
                  ),
                  LandscapeKeypadKeys(
                    text: '5',
                    onPressed: () => calculation('5'),
                  ),
                  LandscapeKeypadKeys(
                    text: '6',
                    onPressed: () => calculation('6'),
                  ),
                  LandscapeKeypadKeys(
                    text: '-',
                    color: kSplColor,
                    onPressed: () => calculation('-'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  LandscapeKeypadKeys(
                    text: '1',
                    onPressed: () => calculation('1'),
                  ),
                  LandscapeKeypadKeys(
                    text: '2',
                    onPressed: () => calculation('2'),
                  ),
                  LandscapeKeypadKeys(
                    text: '3',
                    onPressed: () => calculation('3'),
                  ),
                  LandscapeKeypadKeys(
                    text: '+',
                    color: kSplColor,
                    onPressed: () => calculation('+'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  LandscapeKeypadKeys(
                    text: 'ANS',
                    onPressed: () => calculation('ANS'),
                    color: kSplColor,
                  ),
                  LandscapeKeypadKeys(
                    text: '0',
                    onPressed: () => calculation('0'),
                  ),
                  LandscapeKeypadKeys(
                    text: '.',
                    onPressed: () => calculation('.'),
                  ),
                  LandscapeKeypadKeys(
                    text: '=',
                    color: kSplColor,
                    circle: true,
                    onPressed: () => calculation('='),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
