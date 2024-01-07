import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_vihar_quiz/constants.dart';

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
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250.0,
                      width: 250.0,
                      child: SvgPicture.asset("assets/images/ic_logo.svg"),
                    ),
                    Text(
                      "Welcome to Van Vihar!",
                      style: headingTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Lorem ipsum diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec",
                        style: GoogleFonts.poppins(
                          color: textWhite,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
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
                      onPressed: () {
                        //TODO:Implement login with Google
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
            ],
          ),
        ),
      ),
    );
  }
}
