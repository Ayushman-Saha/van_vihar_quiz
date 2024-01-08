import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/ui/screens/quizScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static String id = "StartString";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    // print(user);
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
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
                      "Welcome, ${user.displayName}",
                      style: headingTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //Rules page
                      "Lorem ipsum diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec",
                      style: bodyTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(QuizScreen.id);
                    },
                    height: 60.0,
                    minWidth: 300.0,
                    color: buttonBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "Start",
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
