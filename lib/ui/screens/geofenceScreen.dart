// import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

class GeofenceScreen extends StatelessWidget {
  const GeofenceScreen({super.key});

  static String id = "GeofenceScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Replace the AssetImage with your illustration
                SvgPicture.asset(
                  'assets/images/ic_denied_permission.svg',
                  width: 200.0,
                  height: 200.0,
                  // You can adjust the width and height based on your illustration size
                ),
                const SizedBox(height: 20.0),
                Text(
                  'You are outside Van Vihar',
                  style: buttonTextStyle.copyWith(color: textWhite),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'To continue, please enter Van Vihar Premises!',
                  textAlign: TextAlign.center,
                  style: bodyTextStyle,
                ),
                const SizedBox(height: 80.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: textWhite,
                    height: 60.0,
                    minWidth: 300.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      // Open device settings to enable location access
                      // You can use a package like 'app_settings' for this
                      // AppSettings.openAppSettings(type: AppSettingsType.location);
                      // await openAppSettings();
                      Navigator.pushNamedAndRemoveUntil(
                          context, StartScreen.id, (route) => false);
                    },
                    child: Text(
                      'Refresh',
                      style: buttonTextStyle.copyWith(color: backgroundGreen),
                    ),
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
