import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  final _questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answer': [
        {'text': 'Black', 'score': 10},
        {'text': 'red', 'score': 8},
        {'text': 'green', 'score': 6},
        {'text': 'white', 'score': 4}
      ]
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answer': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 7},
        {'text': 'Elephant', 'score': 8},
        {'text': 'Lion', 'score': 6}
      ]
    },
    {
      'questionText': 'who\'s is your favourite instructor?',
      'answer': [
        {'text': 'Max', 'score': 2},
        {'text': 'Angela', 'score': 1},
        {'text': 'Max', 'score': 2},
        {'text': 'Angela', 'score': 1}
      ]
    },
  ];

  var _totalScore = 0.0;

  void resetQuiz() {
    setState(() {
      _totalScore -= _totalScore;
      _questionIndex -= _questionIndex;
    });
  }

  void _answerQuestion(var score) {
    _totalScore += score;
    setState(() {
      _totalScore = _totalScore;
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: (_questionIndex < _questions.length)
            ? Quiz(_answerQuestion, _questionIndex, _questions)
            : Result(_totalScore, resetQuiz),
      ),
    );
  }
}
