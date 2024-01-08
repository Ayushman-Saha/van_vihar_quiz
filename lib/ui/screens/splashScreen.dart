import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: Center(
          child: SizedBox(
            height: 250.0,
            width: 250.0,
            child: SvgPicture.asset("assets/images/ic_logo.svg"),
          ),
        ),
      ),
    );
  }
}
