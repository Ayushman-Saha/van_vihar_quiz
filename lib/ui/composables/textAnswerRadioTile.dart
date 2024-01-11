import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';

import '../../constants.dart';

class TextAnswerRadioTile extends StatefulWidget {
  const TextAnswerRadioTile({
    super.key,
    required this.quizController,
    required this.answerChoices,
    required this.index,
    required this.status,
    required this.enabled,
  });

  final QuizController quizController;
  final List<dynamic> answerChoices;
  final int index;
  final TileStatus status;
  final bool enabled;

  @override
  State<TextAnswerRadioTile> createState() => _TextAnswerRadioTileState();
}

class _TextAnswerRadioTileState extends State<TextAnswerRadioTile> {
  String _answer = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: () {
          if (widget.enabled) {
            widget.quizController.currentQuestionSelectedAnswer =
                widget.answerChoices[widget.index];
            _answer = widget.answerChoices[widget.index];
            widget.quizController.selectedIndex = widget.index;
          }
        },
        child: Card(
          color: (widget.status == TileStatus.UNSELECTED)
              ? headerBlue
              : ((widget.status == TileStatus.CORRECT)
                  ? correctGreen
                  : incorrectRed),
          borderOnForeground: true,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.answerChoices[widget.index],
                  style: buttonTextStyle,
                ),
                Radio<String>(
                  toggleable: true,
                  activeColor: buttonBlue,
                  splashRadius: 15,
                  value: widget.answerChoices[widget.index],
                  groupValue:
                      widget.quizController.currentQuestionSelectedAnswer,
                  onChanged: (widget.enabled)
                      ? (String? value) {
                          setState(() {
                            _answer = value!;
                            widget.quizController.selectAnswer(_answer);
                            widget.quizController.selectedIndex = widget.index;
                          });
                        }
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
