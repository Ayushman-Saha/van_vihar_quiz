import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/ui/composables/answerRadioButton.dart';

import '../../controller/quizController.dart';
import '../composables/answerDescription.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  static String id = "QuizScreen";

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var controller = QuizController();
  late Stopwatch stopwatch;
  late Timer t;

  bool isAttempted = false;
  bool isValidated = false;

  bool isCorrect = false;

  List<TileStatus> status = [
    TileStatus.UNSELECTED,
    TileStatus.UNSELECTED,
    TileStatus.UNSELECTED,
    TileStatus.UNSELECTED
  ];

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    stopwatch.start();
    t = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String seconds = ((milli ~/ 1000) % 60)
        .toString()
        .padLeft(2, "0"); // this is for the second
    String minutes = ((milli ~/ 1000) ~/ 60)
        .toString()
        .padLeft(2, "0"); // this is for the minute

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Score: ${controller.getScore()}",
                                style: questionHeadingTextStyle,
                              ),
                              Text(
                                returnFormattedText(),
                                style: questionHeadingTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Question ${controller.getCurrentIndex()}/${controller.getTotalQuestions()}",
                              style: questionHeadingTextStyle,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Q. ${controller.currentQuestion.question}",
                                style: headingTextStyle,
                              ),
                            ],
                          ),
                        ),
                        (!isAttempted)
                            ? AnswerRadioButton(
                                quizController: controller,
                                answerChoices:
                                    controller.currentQuestion.answerChoices,
                                correctAnswer:
                                    controller.currentQuestion.correctAnswer,
                                answerType:
                                    controller.currentQuestion.answerType,
                                status: status,
                                enabled: (!isAttempted && !isValidated),
                              )
                            : AnswerDescription(
                                currentQuestion: controller.currentQuestion,
                                isCorrect: isCorrect,
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        (!isAttempted && !isValidated)
                            ? MaterialButton(
                                onPressed: () {
                                  if (controller.currentQuestionSelectedAnswer
                                      .isNotEmpty) {
                                    stopwatch.stop();
                                    setState(() {
                                      int correctIndex =
                                          controller.validateAnswer();
                                      if (controller.selectedIndex !=
                                          correctIndex) {
                                        status[correctIndex] =
                                            TileStatus.CORRECT;
                                        status[controller.selectedIndex] =
                                            TileStatus.INCORRECT;
                                        isCorrect = false;
                                      } else {
                                        status[controller.selectedIndex] =
                                            TileStatus.CORRECT;
                                        isCorrect = true;
                                      }
                                      // controller.nextQuestion();
                                      isValidated = true;
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Select an option to continue",
                                      toastLength: Toast.LENGTH_SHORT,
                                    );
                                  }
                                  // print(controller.currentQuestionSelectedAnswer);
                                },
                                height: 60,
                                minWidth: 250,
                                color: buttonBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Check Answer",
                                  style: buttonTextStyle,
                                ),
                              )
                            : (isValidated && !isAttempted)
                                ? MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        isAttempted = true;
                                      });

                                      // print(controller.currentQuestionSelectedAnswer);
                                    },
                                    height: 60,
                                    minWidth: 250,
                                    color: buttonBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "See Solution",
                                      style: buttonTextStyle,
                                    ),
                                  )
                                : MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        clearState();
                                        controller.nextQuestion();
                                        stopwatch.start();
                                      });
                                      // print(controller.currentQuestionSelectedAnswer);
                                    },
                                    height: 60,
                                    minWidth: 250,
                                    color: buttonBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "Next",
                                      style: buttonTextStyle,
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    stopwatch.stop();
    t.cancel();
  }

  void clearState() {
    isAttempted = false;
    isValidated = false;
    isCorrect = false;

    status = [
      TileStatus.UNSELECTED,
      TileStatus.UNSELECTED,
      TileStatus.UNSELECTED,
      TileStatus.UNSELECTED
    ];

    controller.resetSelection();
  }
}
