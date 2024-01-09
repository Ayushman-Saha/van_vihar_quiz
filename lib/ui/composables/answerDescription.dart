import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';

class AnswerDescription extends StatelessWidget {
  const AnswerDescription({
    super.key,
    required this.quizController,
  });

  final QuizController quizController;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Hello Bhai"),
    );
  }
}
