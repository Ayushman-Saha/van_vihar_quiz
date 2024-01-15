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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Center(
            child: (controller.getLeaderboard().isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 8),
                          child: Text(
                            "Leaderboard",
                            style: headingTextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Cheers! Your response for today has been recorded.",
                            style: bodyTextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 36.0),
                            child: ListView.builder(
                              itemCount: _leaderboard.length,
                              itemBuilder: (context, index) {
                                return LeaderboardTile(
                                  rank: index + 1,
                                  displayPicture:
                                      _leaderboard[index].displayPicture,
                                  name: _leaderboard[index].name,
                                  score: _leaderboard[index].score,
                                  timeTaken: _leaderboard[index].timeTaken,
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: MaterialButton(
                            onPressed: () async {
                              await _clearScore();
                            },
                            height: 60,
                            minWidth: 250,
                            color: buttonBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: (!_isLoading)
                                ? Text(
                                    "Clear Attempt",
                                    style: buttonTextStyle,
                                  )
                                : const CircularProgressIndicator(
                                    color: textWhite,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(
                    color: textWhite,
                  ),
          ),
        ),
      ),
    );
  }
}
