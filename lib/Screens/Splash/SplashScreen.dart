import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:worthymiles/Screens/Dashboard/Dashboard.dart';
import 'package:worthymiles/Screens/OnBoardingScreens/OnBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 10), (){

      if(FirebaseAuth.instance.currentUser != null){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
    
      }
      else{
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoarding()));

      }
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(),
              SizedBox(height: 10),
              Text("Worthy Walk", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w900, fontSize: 44, fontFamily: GoogleFonts.nunito(
                fontWeight: FontWeight.w900
              ).fontFamily)),
              Lottie.asset("assets/Animations/loading.json", height: 70),
              
              Lottie.asset("assets/Animations/splash.json")
              
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text("@copyrights reserved Hafeez & Hadia"),
            ),
          ),
        ],
      ),
      
    );
  }
}