import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/ui/screens/leaderboardScreen.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';
import 'package:van_vihar_quiz/utils/authUtils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static String id = "OnboardingScreen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isLoading = false;

  Future<void> _checkForAttempt(User user, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var response =
        await http.get(Uri.parse("$BASE_URL/quizResult/get?uid=${user.uid}"));
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 404) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(StartScreen.id, (route) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LeaderboardScreen.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            AssetImage("assets/images/ic_logo_van_vihar.jpg"),
                      ),
                    ),
                    Text(
                      "Welcome to Van Vihar!",
                      style: headingTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Discover Van Vihar National Park in Bhopal like never before! Dive into the biodiversity, play quizzes, and join us in conserving this natural treasure through our engaging quiz app.",
                        style: bodyTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        UserCredential credential = await signInWithGoogle();
                        // print(credential.user);
                        if (credential.user != null) {
                          await _checkForAttempt(credential.user!, context);
                        }
                      },
                      height: 60.0,
                      minWidth: 300.0,
                      color: buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: (!_isLoading)
                          ? Text(
                              "Get started!",
                              style: buttonTextStyle,
                            )
                          : const CircularProgressIndicator(
                              color: textWhite,
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: textWhite,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/ic_logo_iiserb.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "By IISERB",
                        style: bodyTextStyle,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
