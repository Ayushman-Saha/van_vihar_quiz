import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/entities/endScreenArguments.dart';
import 'package:van_vihar_quiz/entities/startScreenArguments.dart';
import 'package:van_vihar_quiz/ui/composables/imageAnswerRadioButton.dart';
import 'package:van_vihar_quiz/ui/composables/logoHeader.dart';
import 'package:van_vihar_quiz/ui/composables/textAnswerRadioButton.dart';
import 'package:van_vihar_quiz/ui/screens/endScreen.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

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
  bool _isAudioLoading = false;

  final _player = AudioPlayer();
  late Duration duration;

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
    controller.initializeQuestions();
  }

  Future<void> _initAudioPlayer() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    // Listen to errors during playback.
    if (controller.currentQuestion.hasAttachment &&
        controller.currentQuestion.attachmentType == "audio") {
      _player.playbackEventStream
          .listen((event) {}, onError: (Object e, StackTrace stackTrace) {});
      try {
        await _player.setUrl(controller.currentQuestion.attachment!);
      } catch (e) {
        Fluttertoast.showToast(
            msg: "AudioPlayer couldn't be initialised",
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.questionList);

    final args =
        ModalRoute.of(context)!.settings.arguments as StartScreenArguments;
    controller = args.controller;
    return (controller.questionList.isNotEmpty)
        ? SafeArea(
            child: Center(
              child: Scaffold(
                body: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 0.7 * MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          gradient: gradient,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)),
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Q. ${controller.currentQuestion.question}",
                                              style: headingTextStyle,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  (controller.currentQuestion.hasAttachment &&
                                          !isValidated)
                                      ? ((controller.currentQuestion
                                                  .attachmentType ==
                                              "image")
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Card(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: const BorderSide(
                                                        width: 4,
                                                        color: textWhite,
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.network(
                                                        width: 0.5 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                        controller
                                                            .currentQuestion
                                                            .attachment!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: SizedBox(
                                                height: 60,
                                                child: Card(
                                                  elevation: 10,
                                                  color: textGreen,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: SvgPicture.asset(
                                                          color: textWhite,
                                                          "assets/images/waves.svg",
                                                        ),
                                                      ),
                                                      IconButton(
                                                        color: textWhite,
                                                        onPressed: () async {
                                                          setState(() {
                                                            _isAudioLoading =
                                                                true;
                                                          });
                                                          await _initAudioPlayer();
                                                          await _player.play();
                                                          setState(() {
                                                            _isAudioLoading =
                                                                false;
                                                          });
                                                        },
                                                        icon: (!_isAudioLoading)
                                                            ? const Icon(
                                                                Icons
                                                                    .play_circle,
                                                                size: 40,
                                                              )
                                                            : const CircularProgressIndicator(
                                                                color:
                                                                    textWhite,
                                                              ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      : const SizedBox(
                                          height: 1,
                                        ),
                                  (!isAttempted)
                                      ? (controller
                                                  .currentQuestion.answerType ==
                                              "text")
                                          ? TextAnswerRadioButton(
                                              quizController: controller,
                                              answerChoices: controller
                                                  .currentQuestion
                                                  .answerChoices,
                                              correctAnswer: controller
                                                  .currentQuestion
                                                  .correctAnswer,
                                              answerType: controller
                                                  .currentQuestion.answerType,
                                              status: status,
                                              enabled: (!isAttempted &&
                                                  !isValidated),
                                            )
                                          : ImageAnswerRadioButton(
                                              quizController: controller,
                                              answerChoices: controller
                                                  .currentQuestion
                                                  .answerChoices,
                                              correctAnswer: controller
                                                  .currentQuestion
                                                  .correctAnswer,
                                              answerType: controller
                                                  .currentQuestion.answerType,
                                              status: status,
                                              enabled: (!isAttempted &&
                                                  !isValidated),
                                            )
                                      : AnswerDescription(
                                          currentQuestion:
                                              controller.currentQuestion,
                                          isCorrect: isCorrect,
                                        ),
                                  Column(
                                    children: [
                                      (!isAttempted && !isValidated)
                                          ? MaterialButton(
                                              onPressed: () {
                                                if (controller
                                                    .currentQuestionSelectedAnswer
                                                    .isNotEmpty) {
                                                  stopwatch.stop();
                                                  _player.stop();
                                                  setState(() {
                                                    int correctIndex =
                                                        controller
                                                            .validateAnswer();
                                                    if (controller
                                                            .selectedIndex !=
                                                        correctIndex) {
                                                      status[correctIndex] =
                                                          TileStatus.CORRECT;
                                                      status[controller
                                                              .selectedIndex] =
                                                          TileStatus.INCORRECT;
                                                      isCorrect = false;
                                                    } else {
                                                      status[controller
                                                              .selectedIndex] =
                                                          TileStatus.CORRECT;
                                                      isCorrect = true;
                                                    }
                                                    // controller.nextQuestion();
                                                    isValidated = true;
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Select an option to continue",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                }
                                                // print(controller.currentQuestionSelectedAnswer);
                                              },
                                              height: 60,
                                              minWidth: 250,
                                              color: buttonBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Text(
                                                    "See Solution",
                                                    style: buttonTextStyle,
                                                  ),
                                                )
                                              : (!controller.isLastQuestion)
                                                  ? MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          clearState();
                                                          _player.stop();
                                                          controller
                                                              .nextQuestion();
                                                          stopwatch.start();
                                                        });
                                                        // print(controller.currentQuestionSelectedAnswer);
                                                      },
                                                      height: 60,
                                                      minWidth: 250,
                                                      color: buttonBlue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Text(
                                                        "Next",
                                                        style: buttonTextStyle,
                                                      ),
                                                    )
                                                  : MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          stopwatch.stop();
                                                          _player.stop();
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                            EndScreen.id,
                                                            ModalRoute.withName(
                                                              StartScreen.id,
                                                            ),
                                                            arguments: EndScreenArguments(
                                                                score: controller
                                                                    .getScore(),
                                                                timeTaken: stopwatch
                                                                    .elapsedMilliseconds,
                                                                correctAttemptedQuestionIds:
                                                                    controller
                                                                        .getCorrectAttemptedQuestionIds(),
                                                                attemptedQuestionIds:
                                                                    controller
                                                                        .getAttemptedQuestionIds()),
                                                          );
                                                        });
                                                        // print(controller.currentQuestionSelectedAnswer);
                                                      },
                                                      height: 60,
                                                      minWidth: 250,
                                                      color: buttonBlue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Text(
                                                        "Submit",
                                                        style: buttonTextStyle,
                                                      ),
                                                    ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Column(
                          children: [
                            const LogoHeader(),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          "Score: ${controller.getScore()}",
                                          style: questionHeadingTextStyle,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          returnFormattedTime(
                                              stopwatch.elapsedMilliseconds),
                                          style: questionHeadingTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        "Question ${controller.getCurrentIndex()}/${controller.getTotalQuestions()}",
                                        style: questionHeadingTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : const SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    stopwatch.stop();
    t.cancel();
    _player.dispose();
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
