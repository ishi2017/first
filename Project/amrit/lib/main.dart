import 'package:flutter/material.dart';
import './Question.dart';
import './answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var QuestionNo = 0;
  var Questions = const [
    {
      'Ques': 'Which one is your favourit Animal ?',
      'Ans': ['cat', 'Dog', 'Mouse', 'Rat']
    },
    {
      'Ques': 'Which one is your favourit Movie ?',
      'Ans': ['DDLJ', 'Kabhi Khushi Kabhi Gam', 'Ram Jame', 'DON']
    },
    {
      'Ques': 'Which one is your favourite Teacher ?',
      'Ans': ['Ram', 'Shayam', 'Nikhil', 'Saroj']
    },
  ];
  void answerQuestion() {
    setState(() {
      print(QuestionNo);

      QuestionNo += 1;

      if (QuestionNo == 3) {
        QuestionNo = 0;
      }
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
        body: Column(
          children: [
            Question('Que No::' +
                QuestionNo.toString() +
                '\t' +
                Questions[QuestionNo]['Ques'].toString()),
            ...(Questions[QuestionNo]['Ans'] as List<String>).map((ans) {
              return Answer(answerQuestion, ans);
            }),
          ],
        ),
      ),
    );
  }
}
