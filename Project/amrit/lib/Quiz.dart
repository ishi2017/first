import 'package:flutter/material.dart';
import './Question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final Questions;
  final int QuestionNo;
  final Function answerQuestion;
  Quiz(
      {@required this.QuestionNo,
      @required this.Questions,
      @required this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Question('Que No::' +
            (QuestionNo + 1).toString() +
            '\t' +
            Questions[QuestionNo]['Ques'].toString()),
        ...(Questions[QuestionNo]['Ans'] as List<Map<String, Object>>)
            .map((ans) {
          return Answer(() => answerQuestion(ans['score']), ans['text']);
        }),
      ],
    ));
  }
}
