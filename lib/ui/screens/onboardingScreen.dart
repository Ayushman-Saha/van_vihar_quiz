import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/credentials.dart';
import 'package:van_vihar_quiz/ui/composables/logoHeader.dart';
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: 0.6 * MediaQuery.of(context).size.width,
                  child: Text(
                    "The Van Vihar Quiz",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 42),
                      color: textWhite,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 0.5 * MediaQuery.of(context).size.width,
                  child: Text(
                    "Play and get a chance to get a free ticket!",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: buttonBlue),
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/images/ic_illust.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: MaterialButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
