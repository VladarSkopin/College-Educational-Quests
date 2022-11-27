import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_constants.dart';
import '../../widgets/option_widget.dart';

class QuizScreen extends StatefulWidget {
  // list of questions
  final List<Map<String, Object>> questions;
  // quiz name -> will be used in SharedPreferences
  final String quizName;
  // name of page route
  final String routeName;

  const QuizScreen({
    Key? key,
    required this.questions,
    required this.quizName,
    required this.routeName
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;
  bool optionIsSelected = false;
  bool endOfQuiz = false;
  String _finishContent = 'You\'ve obtained a stack of coins';

  void _questionAnswered(bool isOptionCorrect) {
    setState(() {
      // option was selected
      optionIsSelected = true;
      // check if the answer is correct
      if (isOptionCorrect) {
        _totalScore++;
      }
      // when the quiz ends
      if (_questionIndex + 1 == widget.questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() async {

    setState(() {
      _questionIndex++;
      optionIsSelected = false;
      if (_questionIndex + 1 == widget.questions.length) {
        endOfQuiz = true;
      }
    });
  }


  void _finishQuiz() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.quizName, _totalScore);

    setState(() {
      switch(_totalScore) {
        case 2:
          _finishContent = 'Неплохо...';
          break;
        case 3 :
          _finishContent = 'Весьма неплохо...';
          break;
        case 4 :
          _finishContent = 'Хороший результат!';
          break;
        case 5 :
          _finishContent = 'Отличный результат!';
          break;
        default:
          _finishContent = 'Не сдавайтесь!';
          break;
      }
    });

    showDialog(
        context: context,
        builder: (BuildContext context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: AlertDialog(
            backgroundColor: Colors.blue.shade800,
            title: Column(
              children: [
                const SizedBox(height: 20),
                Text('Вы набрали $_totalScore из ${widget.questions.length} баллов',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                Text('\n$_finishContent',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 22), textAlign: TextAlign.center)
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, widget.routeName);
                }, // pass it from Maps screen
                child: const Text('OK',
                    style: TextStyle(
                        color: Colors.white, fontSize: 24)),
              ),
            ],
          ),
        ));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: boxDecorationDefault,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text.rich(
                    TextSpan(
                        text: 'Текущий счёт: $_totalScore ',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 22, color: Colors.grey[300], fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: '/ ${widget.questions.length}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.grey[300]),
                          )
                        ]
                    ),
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text(
                        widget.questions[_questionIndex]['question'].toString(),
                        style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 20, color: Colors.white)
                    ),
                  ),
                  ...(widget.questions[_questionIndex]['options'] as List<Map<String, Object>>)
                      .map((option) => OptionWidget(
                    optionText: option['optionText'].toString(),
                    optionColor: optionIsSelected ? option['isOptionCorrect'] as bool ? Colors.green.shade300 : Colors.red.shade800 : Colors.grey.shade200,
                    optionTap: () {
                      if (optionIsSelected) {
                        return;
                      }
                      _questionAnswered(option['isOptionCorrect'] as bool);
                    },
                  )),
                  const SizedBox(height: 10),
                  MaterialButton(
                      onPressed: optionIsSelected ? endOfQuiz ? _finishQuiz : _nextQuestion : null,
                      color: Colors.deepPurple,
                      disabledColor: Colors.blueGrey,
                      elevation: 6.0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(endOfQuiz ? 'ФИНИШ' : 'ДАЛЬШЕ', style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.white, fontSize: 20))),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
