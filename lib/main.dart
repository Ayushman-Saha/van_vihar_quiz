import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:van_vihar_quiz/constants.dart';
import 'package:van_vihar_quiz/firebase_options.dart';
import 'package:van_vihar_quiz/ui/screens/endScreen.dart';
import 'package:van_vihar_quiz/ui/screens/onboardingScreen.dart';
import 'package:van_vihar_quiz/ui/screens/quizScreen.dart';
import 'package:van_vihar_quiz/ui/screens/splashScreen.dart';
import 'package:van_vihar_quiz/ui/screens/startScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundBlue,
        primaryColor: backgroundBlue,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnboardingScreen.id: (context) => const OnboardingScreen(),
        StartScreen.id: (context) => const StartScreen(),
        QuizScreen.id: (context) => const QuizScreen(),
        EndScreen.id: (context) => const EndScreen()
      },
    );
  }
}
