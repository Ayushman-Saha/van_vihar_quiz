import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';
import 'package:van_vihar_quiz/utils/authUtils.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static String id = "OnboardingScreen";

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
                        "Lorem ipsum diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec",
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
                          await Navigator.of(context).pushNamedAndRemoveUntil(
                              StartScreen.id, (route) => false);
                        }
                        // print("Hello World");
                      },
                      height: 60.0,
                      minWidth: 300.0,
                      color: buttonBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        "Get started!",
                        style: buttonTextStyle,
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
