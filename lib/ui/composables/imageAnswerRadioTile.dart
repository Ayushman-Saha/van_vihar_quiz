import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../controller/quizController.dart';

class ImageAnswerRadioTile extends StatefulWidget {
  const ImageAnswerRadioTile({
    super.key,
    required this.quizController,
    required this.answerChoices,
    required this.index,
    required this.status,
    required this.enabled,
  });

  final QuizController quizController;
  final List<String> answerChoices;
  final int index;
  final TileStatus status;
  final bool enabled;

  @override
  State<ImageAnswerRadioTile> createState() => _ImageAnswerRadioTileState();
}

class _ImageAnswerRadioTileState extends State<ImageAnswerRadioTile> {
  String _answer = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
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
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(width: 8, color: textWhite),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      widget.answerChoices[widget.index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Radio<String>(
                  toggleable: true,
                  activeColor: buttonBlue,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
