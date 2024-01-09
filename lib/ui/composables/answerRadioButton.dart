import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';

class AnswerRadioButton extends StatefulWidget {
  const AnswerRadioButton({
    super.key,
    required this.quizController,
    required this.answerChoices,
    required this.correctAnswer,
    required this.answerType,
  });

  final QuizController quizController;
  final List<String> answerChoices;
  final String correctAnswer;
  final String answerType;

  @override
  State<AnswerRadioButton> createState() => _AnswerRadioButtonState();
}

class _AnswerRadioButtonState extends State<AnswerRadioButton> {
  String _answer = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () {
                widget.quizController.currentQuestionSelectedAnswer =
                    widget.answerChoices[0];
                _answer = widget.answerChoices[0];
              },
              child: Card(
                color: headerBlue,
                borderOnForeground: true,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.answerChoices[0],
                        style: buttonTextStyle,
                      ),
                      Radio<String>(
                        value: widget.answerChoices[0],
                        groupValue: _answer,
                        onChanged: (String? value) {
                          setState(() {
                            _answer = value!;
                            widget.quizController.selectAnswer(_answer);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () {
                widget.quizController.currentQuestionSelectedAnswer =
                    widget.answerChoices[1];
                _answer = widget.answerChoices[1];
              },
              child: Card(
                color: headerBlue,
                borderOnForeground: true,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.answerChoices[1],
                        style: buttonTextStyle,
                      ),
                      Radio<String>(
                        value: widget.answerChoices[1],
                        groupValue: _answer,
                        onChanged: (String? value) {
                          setState(() {
                            _answer = value!;
                            widget.quizController.selectAnswer(_answer);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () {
                widget.quizController.currentQuestionSelectedAnswer =
                    widget.answerChoices[2];
                _answer = widget.answerChoices[2];
              },
              child: Card(
                color: headerBlue,
                borderOnForeground: true,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.answerChoices[2],
                        style: buttonTextStyle,
                      ),
                      Radio<String>(
                        value: widget.answerChoices[2],
                        groupValue: _answer,
                        onChanged: (String? value) {
                          setState(() {
                            _answer = value!;
                            widget.quizController.selectAnswer(_answer);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: GestureDetector(
              onTap: () {
                widget.quizController.currentQuestionSelectedAnswer =
                    widget.answerChoices[3];
                _answer = widget.answerChoices[3];
              },
              child: Card(
                color: headerBlue,
                borderOnForeground: true,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.answerChoices[3],
                        style: buttonTextStyle,
                      ),
                      Radio<String>(
                        value: widget.answerChoices[3],
                        groupValue: _answer,
                        onChanged: (String? value) {
                          setState(() {
                            _answer = value!;
                            widget.quizController.selectAnswer(_answer);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
