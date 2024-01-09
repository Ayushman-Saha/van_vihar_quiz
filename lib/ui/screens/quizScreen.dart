import 'dart:async';

import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/ui/composables/answerRadioButton.dart';

import '../../controller/quizController.dart';

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
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                controller.currentQuestion.question,
                                style: buttonTextStyle,
                              ),
                            ],
                          ),
                        ),
                        AnswerRadioButton(
                          quizController: controller,
                          answerChoices:
                              controller.currentQuestion.answerChoices,
                          correctAnswer:
                              controller.currentQuestion.correctAnswer,
                          answerType: controller.currentQuestion.answerType,
                          status: status,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              int correctIndex = controller.validateAnswer();
                              if (controller.selectedIndex != correctIndex) {
                                status[correctIndex] = TileStatus.CORRECT;
                                status[controller.selectedIndex] =
                                    TileStatus.INCORRECT;
                              } else {
                                status[controller.selectedIndex] =
                                    TileStatus.CORRECT;
                              }
                            });
                            print(controller.currentQuestionSelectedAnswer);
                          },
                          height: 60,
                          minWidth: 150,
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
  }
}
