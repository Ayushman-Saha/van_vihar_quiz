import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/controller/leaderboardController.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/entities/leaderboardData.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

import '../composables/leaderboardTile.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});
  static String id = "LeaderBoardScreen";

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late final User user;
  bool _isLoading = false;

  late Timer t;

  final LeaderboardController controller = LeaderboardController();
  late List<LeaderboardData> _leaderboard;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    controller.initializeLeaderboard().then((value) => {
          setState(() {
            _leaderboard = controller.getLeaderboard();
          })
        });
    t = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {});
    });
  }

  Future<void> _clearScore() async {
    setState(() {
      _isLoading = true;
    });
    var response = await http
        .post(Uri.parse("$BASE_URL/quizResult/clear?uid=${user.uid}"));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Cleared the progress", toastLength: Toast.LENGTH_SHORT);
      await Navigator.pushNamedAndRemoveUntil(
          context, StartScreen.id, (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Error while creating the progress!",
          toastLength: Toast.LENGTH_LONG);
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _differenceFromNextDay() {
    var currentDate = DateTime.now();
    DateTime tomorrow;
    if (currentDate.hour >= 00 && currentDate.hour < 04) {
      tomorrow = currentDate;
    } else {
      tomorrow = currentDate.add(const Duration(days: 1));
    }
    tomorrow = tomorrow.copyWith(hour: 04, minute: 00, second: 00);
    var difference = tomorrow.difference(currentDate).inMilliseconds;

    String seconds = ((difference ~/ 1000) % 60).toString().padLeft(2, '0');
    String minutes =
        (((difference ~/ 1000) ~/ 60) % 60).toString().padLeft(2, '0');
    String hours =
        (((difference ~/ 1000) ~/ 60) ~/ 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: (controller.getLeaderboard().isNotEmpty)
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 0.75 * MediaQuery.of(context).size.height,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            // gradient: gradient,
                            color: textWhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 36.0),
                                  child: ListView.builder(
                                    itemCount: _leaderboard.length,
                                    itemBuilder: (context, index) {
                                      return LeaderboardTile(
                                        uid: _leaderboard[index].uid,
                                        rank: index + 1,
                                        displayPicture:
                                            _leaderboard[index].displayPicture,
                                        name: _leaderboard[index].name,
                                        score: _leaderboard[index].score,
                                        timeTaken:
                                            _leaderboard[index].timeTaken,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: MaterialButton(
                              //     onPressed: () async {
                              //       await _clearScore();
                              //     },
                              //     height: 60,
                              //     minWidth: 250,
                              //     color: buttonGreen,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(15),
                              //     ),
                              //     child: (!_isLoading)
                              //         ? Text(
                              //             "Clear Attempt",
                              //             style: buttonTextStyle,
                              //           )
                              //         : const CircularProgressIndicator(
                              //             color: textGreen,
                              //           ),
                              //   ),
                              // ),
                            ],
                          ),
                        )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 0.25 * MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.7 * MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 16),
                                    child: Text(
                                      "Leaderboard",
                                      style: headingTextStyle,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      "Cheers! Your response for today has been recorded.",
                                      style: bodyTextStyle,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 0.3 * MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Participate again in ${_differenceFromNextDay()}",
                                    style: headingTextStyle,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: textWhite,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }
}
