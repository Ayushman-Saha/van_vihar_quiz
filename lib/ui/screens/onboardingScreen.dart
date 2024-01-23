import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Container(
                  height: 0.8 * MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // gradient: gradient,
                      color: textWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: SizedBox(
                          width: 0.6 * MediaQuery.of(context).size.width,
                          child: Text(
                            "The Van Vihar Quiz",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(fontSize: 42),
                              color: backgroundGreen,
                              fontWeight: FontWeight.bold,
                              // shadows: <Shadow>[
                              //   const Shadow(
                              //     offset: Offset(5.0, 5.0),
                              //     blurRadius: 3.0,
                              //     color: Color.fromARGB(255, 0, 0, 0),
                              //   ),
                              // ],
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
                              textStyle: const TextStyle(color: buttonGreen),
                              fontWeight: FontWeight.bold,
                              // shadows: <Shadow>[
                              //   const Shadow(
                              //     offset: Offset(5.0, 5.0),
                              //     blurRadius: 3.0,
                              //     color: Color.fromARGB(255, 0, 0, 0),
                              //   ),
                              // ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          "assets/images/ic_quiz.svg",
                          height: 0.2 * MediaQuery.of(context).size.height,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: MaterialButton(
                          onPressed: () async {
                            UserCredential credential =
                                await signInWithGoogle();
                            // print(credential.user);
                            if (credential.user != null) {
                              await _checkForAttempt(credential.user!, context);
                            }
                          },
                          height: 60.0,
                          minWidth: 300.0,
                          color: buttonGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: (!_isLoading)
                              ? Text(
                                  "Get started!",
                                  style: buttonTextStyle,
                                )
                              : const CircularProgressIndicator(
                                  color: textGreen,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Developed by IISER Bhopal',
                          style: bodyTextStyle.copyWith(color: backgroundGreen),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 0.25 * MediaQuery.of(context).size.height,
                child: Column(
                  children: const [
                    LogoHeader(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
