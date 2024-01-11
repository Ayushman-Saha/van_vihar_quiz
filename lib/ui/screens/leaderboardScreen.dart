import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});
  static String id = "LeaderBoardScreen";

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late final User user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  Future<void> _clearScore() async {
    setState(() {
      _isLoading = true;
    });
    var response = await http
        .post(Uri.parse("${BASE_URL}/quizResult/clear?uid=${user.uid}"));
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You have already attempted the quiz. Multiple entries aren't permitted. This will be replaced by leaderboard",
                  style: bodyTextStyle,
                  textAlign: TextAlign.center,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
