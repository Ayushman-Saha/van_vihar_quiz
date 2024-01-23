import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/ui/screens/leaderboardScreen.dart';
import 'package:van_vihar_quiz/ui/screens/onboardingScreen.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil(OnboardingScreen.id, (route) => false),
      );
    } else {
      _checkForAttempt();
    }
  }

  Future<void> _checkForAttempt() async {
    var response = await http
        .get(Uri.parse("${BASE_URL}/quizResult/get?uid=${user!.uid}"));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var data = json["data"]["createdAt"];
      var nextDayTime = DateTime.now().add(const Duration(days: 1));
      var specificTime = nextDayTime.copyWith(hour: 04, minute: 00, second: 00);
      // print(DateTime.parse(data).toLocal());
      // print(specificTime);
      // print(specificTime.difference(DateTime.parse(data).toLocal()).inHours);
      if (specificTime.difference(DateTime.parse(data).toLocal()).inHours <
          28) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context)
              .pushNamedAndRemoveUntil(LeaderboardScreen.id, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context)
              .pushNamedAndRemoveUntil(StartScreen.id, (route) => false),
        );
      }
    } else if (response.statusCode == 404) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil(StartScreen.id, (route) => false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: backgroundGreen),
          child: Center(
            child: SizedBox(
              height: 250.0,
              width: 250.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/ic_logo.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
