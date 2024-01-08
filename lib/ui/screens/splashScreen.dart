import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:van_vihar_quiz/ui/screens/onboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //TODO: Check for user presence. If yes, navigate directly to score or start screen

    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context)
          .pushNamedAndRemoveUntil(OnboardingScreen.id, (route) => false),
    );
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
