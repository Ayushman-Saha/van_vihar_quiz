import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/controller/quizController.dart';
import 'package:van_vihar_quiz/entities/startScreenArguments.dart';
import 'package:van_vihar_quiz/ui/composables/logoHeader.dart';
import 'package:van_vihar_quiz/ui/screens/deniedLocationScreen.dart';
import 'package:van_vihar_quiz/ui/screens/onboardingScreen.dart';
import 'package:van_vihar_quiz/ui/screens/quizScreen.dart';

import 'geofenceScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static String id = "StartString";

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late User user;
  bool _isLoading = false;
  bool isGeofenceCrossed = false;
  final QuizController controller = QuizController();

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Fluttertoast.showToast(
          msg: "Enable location services to continue",
          toastLength: Toast.LENGTH_LONG);
      setState(() {
        _isLoading = false;
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Fluttertoast.showToast(
            msg: "Location permissions must be granted in order to continue",
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          _isLoading = false;
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(DeniedLocationScreen.id, (route) => false);
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // print(user);
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: textWhite),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoHeader(),
              const SizedBox(
                height: 75,
              ),
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
                      style: headingTextStyle.copyWith(color: backgroundGreen),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Quiz Rules",
                      style: bodyTextStyle.copyWith(
                          fontWeight: FontWeight.bold, color: backgroundGreen),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Text(
                      //Rules page
                      "\n 1.Eligibility: Open to all participants.\n\n 2.Fair Play: Answer questions honestly and independently.\n\n 3. Quiz Time Limit: 100 seconds. The timer pauses for additional reading on each question. \n\n4.Participation: Engage in quizzes to test knowledge and win exciting prizes\*.\n\n 5.Prizes: Prizes are non-transferable and subject to availability\*.\n\n \* Terms and condition apply",
                      style: bodyTextStyle.copyWith(color: backgroundGreen),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
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
                        var position = await determinePosition();
                        isGeofenceCrossed =
                            await controller.initializeQuestions(
                                position.latitude, position.longitude);
                        setState(() {
                          _isLoading = false;
                        });

                        if (!isGeofenceCrossed) {
                          Navigator.of(context).pushNamed(
                            QuizScreen.id,
                            arguments:
                                StartScreenArguments(controller: controller),
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              GeofenceScreen.id, (route) => false);
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
                      color: buttonGreen,
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
