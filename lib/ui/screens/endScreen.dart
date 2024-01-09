import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});
  static String id = "EndScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          body: Text(
            "EndScreen",
            style: bodyTextStyle,
          ),
        ),
      ),
    );
  }
}
