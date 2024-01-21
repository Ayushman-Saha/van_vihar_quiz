import 'dart:async';

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
    // print(response.statusCode);
    if (response.statusCode != 404) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(gradient: gradient),
          child: Center(
            child: SizedBox(
              height: 250.0,
              width: 250.0,
              child: Image.asset("assets/images/ic_logo.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
