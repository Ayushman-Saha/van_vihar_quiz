import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/ui/screens/leaderboardScreen.dart';

import '../../entities/endScreenArguments.dart';

class EndScreen extends StatefulWidget {
  const EndScreen({super.key});
  static String id = "EndScreen";

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  late User user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  Future<void> _updateScore(int score, int timeTaken, List<String> attemptedQuestionIds, List<String> correctAttemptedQuestionIds) async {

    Map<String, dynamic> data = {
      "uid": user.uid,
      "name": user.displayName,
      "email": user.email,
      "score": score,
      "timeTaken": timeTaken,
      "attemptedQuestionIds" : attemptedQuestionIds,
      "correctAttemptedQuestionIds": correctAttemptedQuestionIds
    };

    Map<String, String> headers = {"content-type": "application/json"};

    var body = jsonEncode(data);
    // print(body);

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse("${BASE_URL}/quizResult/add"),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Scores updated successfully", toastLength: Toast.LENGTH_LONG);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LeaderboardScreen.id, (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Error while updating the scores",
          toastLength: Toast.LENGTH_LONG);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    final args =
        ModalRoute.of(context)!.settings.arguments as EndScreenArguments;

    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Center(
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
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                          radius: 50.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Congratulations!, ${user.displayName}",
                          style: headingTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          //Rules page
                          "You have scored ${args.score}",
                          style: bodyTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          //Rules page
                          "Time taken by you is ${(args.timeTaken ~/ (1000 * 60))} minutes and ${args.timeTaken ~/ 1000} seconds",
                          style: bodyTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: MaterialButton(
                      onPressed: () async {
                        _updateScore(args.score, args.timeTaken, args.attemptedQuestionIds,args.correctAttemptedQuestionIds);
                      },
                      height: 60,
                      minWidth: 250,
                      color: buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: (!_isLoading)
                          ? Text(
                              "Continue",
                              style: buttonTextStyle,
                            )
                          : const CircularProgressIndicator(
                              color: textWhite,
                            ),
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
