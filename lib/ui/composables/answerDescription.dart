import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/entities/quizQuestion.dart';

class AnswerDescription extends StatelessWidget {
  const AnswerDescription({
    super.key,
    required this.currentQuestion,
    required this.isCorrect,
  });

  final QuizQuestion currentQuestion;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                width: 125,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: (isCorrect) ? correctGreen : incorrectRed,
                  child: (isCorrect)
                      ? Center(
                          child: Text(
                            "Correct",
                            style: buttonTextStyle,
                          ),
                        )
                      : Center(
                          child: Text(
                            "Incorrect",
                            style: buttonTextStyle,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 125,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: headerBlue,
                  child: Center(
                    child: Text(
                      currentQuestion.difficulty.capitalizeFirst!,
                      style: buttonTextStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          (currentQuestion.descriptionAttachment != null)
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(
                          currentQuestion.descriptionAttachment!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 1,
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              currentQuestion.answerDescription,
              style: bodyTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
