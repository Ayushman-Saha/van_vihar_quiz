import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';

import '../../entities/endScreenArguments.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});
  static String id = "EndScreen";

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
                    "Time taken by you is ${returnFormattedTime(args.timeTaken)} minutes",
                    style: bodyTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
