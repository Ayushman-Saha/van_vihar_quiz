import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/ui/composables/imageAnswerRadioTile.dart';

import '../../constants.dart';
import '../../controller/quizController.dart';

class ImageAnswerRadioButton extends StatefulWidget {
  const ImageAnswerRadioButton({
    super.key,
    required this.quizController,
    required this.answerChoices,
    required this.correctAnswer,
    required this.answerType,
    required this.status,
    required this.enabled,
  });

  final QuizController quizController;
  final List<dynamic> answerChoices;
  final String correctAnswer;
  final String answerType;
  final List<TileStatus> status;
  final bool enabled;

  @override
  State<ImageAnswerRadioButton> createState() => _ImageAnswerRadioButtonState();
}

class _ImageAnswerRadioButtonState extends State<ImageAnswerRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ImageAnswerRadioTile(
                  quizController: widget.quizController,
                  answerChoices: widget.answerChoices,
                  index: 0,
                  status: widget.status[0],
                  enabled: widget.enabled,
                ),
              ),
              Expanded(
                child: ImageAnswerRadioTile(
                  quizController: widget.quizController,
                  answerChoices: widget.answerChoices,
                  index: 1,
                  status: widget.status[1],
                  enabled: widget.enabled,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ImageAnswerRadioTile(
                  quizController: widget.quizController,
                  answerChoices: widget.answerChoices,
                  index: 2,
                  status: widget.status[2],
                  enabled: widget.enabled,
                ),
              ),
              Expanded(
                child: ImageAnswerRadioTile(
                  quizController: widget.quizController,
                  answerChoices: widget.answerChoices,
                  index: 3,
                  status: widget.status[3],
                  enabled: widget.enabled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
