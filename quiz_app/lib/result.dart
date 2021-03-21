import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final score, resetQuiz;
  Result(this.score, this.resetQuiz);

  String get resultPhrase {
    var resultText = 'You did it!';
    if (score < 15)
      resultText = 'You are innocent';
    else if (score > 15)
      resultText = 'You are a good person';
    else if (score > 18)
      resultText = "Here come's the Bad guy!";
    else
      resultText = resultText;
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Center(
            child: Text(
              resultPhrase,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: resetQuiz,
          child: Text('Restart Quiz'),
        )
      ],
    );
  }
}
