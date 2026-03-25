import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/splash_screen_ui.dart';
import 'views/home_ui.dart';
import 'views/bmi_ui.dart';
import 'views/bmr_ui.dart';
import 'views/about_ui.dart';

void main() {
  runApp(
    const FlutterBodyHealthCalculatorApp(),
  );
}

class FlutterBodyHealthCalculatorApp extends StatefulWidget {
  const FlutterBodyHealthCalculatorApp({super.key});

  @override
  State<FlutterBodyHealthCalculatorApp> createState() => _FlutterBodyHealthCalculatorAppState();
}

class _FlutterBodyHealthCalculatorAppState extends State<FlutterBodyHealthCalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreenUI(),
      routes: {
        '/home': (context) => const HomeUi(),
        '/bmi': (context) => const BmiUi(),
        '/bmr': (context) => const BmrUi(),
        '/about': (context) => const AboutUi(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
