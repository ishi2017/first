import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Quiz.dart';
import 'package:flutter_complete_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var totalScore = 0;
  var QuestionNo = 0;
  var Questions = const [
    {
      'Ques': 'Which one is your favourit Animal ?',
      'Ans': [
        {'text': 'cat', 'score': 1},
        {'text': 'Dog', 'score': 2},
        {'text': 'Fly', 'score': 3},
        {'text': 'Rat', 'score': 5}
      ]
    },
    {
      'Ques': 'Which one is your favourit Movie ?',
      'Ans': [
        {'text': 'DDLJ', 'score': 1},
        {'text': 'Kabhi Khushi Kabhi Gam', 'score': 2},
        {'text': 'Ram Jame', 'score': 4},
        {'text': 'DON', 'score': 3}
      ]
    },
    {
      'Ques': 'Which one is your favourite Teacher ?',
      'Ans': [
        {'text': 'Ram', 'score': 1},
        {'text': 'Shayam', 'score': 4},
        {'text': 'Nikhil', 'score': 5},
        {'text': 'Saroj', 'score': 3}
      ]
    },
  ];
  void reset() {
    setState(() {
      totalScore = 0;
      QuestionNo = 0;
    });
  }

  void answerQuestion(int score) {
    setState(() {
      totalScore += score;
      print(QuestionNo);

      QuestionNo += 1;

      // if (QuestionNo == 3) {
      //   QuestionNo = 0;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text(
          "Test Series",
          style: TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        )),
        body: QuestionNo <= 2
            ? Quiz(
                QuestionNo: QuestionNo,
                Questions: Questions,
                answerQuestion: answerQuestion)
            : result(
                totalScore: totalScore,
                reset: reset,
              ),
      ),
    );
  }
}
