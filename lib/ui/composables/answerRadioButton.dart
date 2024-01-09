import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';
import 'package:van_vihar_quiz/ui/composables/answerRadioTile.dart';

class AnswerRadioButton extends StatefulWidget {
  const AnswerRadioButton({
    super.key,
    required this.quizController,
    required this.answerChoices,
    required this.correctAnswer,
    required this.answerType,
    required this.status,
    required this.enabled,
  });

  final QuizController quizController;
  final List<String> answerChoices;
  final String correctAnswer;
  final String answerType;
  final List<TileStatus> status;
  final bool enabled;

  @override
  State<AnswerRadioButton> createState() => _AnswerRadioButtonState();
}

class _AnswerRadioButtonState extends State<AnswerRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnswerRadioTile(
            quizController: widget.quizController,
            answerChoices: widget.answerChoices,
            index: 0,
            status: widget.status[0],
            enabled: widget.enabled,
          ),
          AnswerRadioTile(
            quizController: widget.quizController,
            answerChoices: widget.answerChoices,
            index: 1,
            status: widget.status[1],
            enabled: widget.enabled,
          ),
          AnswerRadioTile(
            quizController: widget.quizController,
            answerChoices: widget.answerChoices,
            index: 2,
            status: widget.status[2],
            enabled: widget.enabled,
          ),
          AnswerRadioTile(
            quizController: widget.quizController,
            answerChoices: widget.answerChoices,
            index: 3,
            status: widget.status[3],
            enabled: widget.enabled,
          ),
        ],
      ),
    );
  }
}
