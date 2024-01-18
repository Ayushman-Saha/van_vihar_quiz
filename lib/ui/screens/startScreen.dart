import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';
import 'package:van_vihar_quiz/entities/startScreenArguments.dart';
import 'package:van_vihar_quiz/ui/screens/onboardingScreen.dart';
import 'package:van_vihar_quiz/ui/screens/quizScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static String id = "StartString";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late User user;
  bool _isLoading = false;
  final QuizController controller = QuizController();

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                      "Quiz Rules",
                      style: buttonTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Text(
                      //Rules page
                      "\n 1.Eligibility: Open to all participants.\n 2.Fair Play: Answer questions honestly and independently.\n 3.Participation: Engage in quizzes for a chance to win free tickets.\n 4.Prizes: Prizes are non-transferable and subject to availability.",
                      style: bodyTextStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await controller.initializeQuestions();
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pushNamed(
                          QuizScreen.id,
                          arguments:
                              StartScreenArguments(controller: controller),
                        );
                      },
                      height: 60.0,
                      minWidth: 300.0,
                      color: buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: (!_isLoading)
                          ? Text(
                              "Start",
                              style: buttonTextStyle,
                            )
                          : const CircularProgressIndicator(
                              color: textWhite,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        await GoogleSignIn().signOut();
                        // await GoogleSignIn().disconnect();
                        await Navigator.of(context).pushNamedAndRemoveUntil(
                            OnboardingScreen.id, (route) => false);
                      },
                      height: 60.0,
                      minWidth: 300.0,
                      color: buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Sign Out",
                        style: buttonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
