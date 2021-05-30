import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:worthymiles/Screens/OnBoardingScreens/OnBoarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worthymiles/Screens/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("${GoogleFonts.nunito().fontFamily} : font is used");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Worthy Miles',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
