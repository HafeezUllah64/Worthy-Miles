import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:worthymiles/Screens/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:worthymiles/Screens/Authentication/Login/components/background.dart';
import 'package:worthymiles/Screens/Authentication/Signup/signup_screen.dart';
import 'package:worthymiles/Screens/Dashboard/Dashboard.dart';
import 'package:worthymiles/components/already_have_an_account_acheck.dart';
import 'package:worthymiles/components/rounded_input_field.dart';
import 'package:worthymiles/components/rounded_password_field.dart';
import 'package:worthymiles/constants.dart';

class Body extends StatelessWidget {
   Body({
    Key key,
  }) : super(key: key);
 final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
 String email = "";
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
             Lottie.asset("assets/Animations/signup.json", height: 250),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              hint: "Password",
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedLoadingButton(
              color: kPrimaryColor,
              width: MediaQuery.of(context).size.width * 0.8,
              child:
                  Text('    LOGIN    ', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed:(){
                 loginUser(context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            TextButton(child: Text("Forgot Password?"), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder : (context) =>ForgotPasswordScreen() ));
            },)
          ,
          
            Divider(color: Colors.grey[400], endIndent: 40, indent: 40,),
             AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),

            ],
        ),
      ),
    );
  }

  
  loginUser(context) async {
    if (email.isEmpty || !email.contains("@") || !email.contains(".com")) {
      Fluttertoast.showToast(msg: "Please enter a valid Email");
      _btnController.reset();
      return;
    }
    if (password.isEmpty || password.length < 8) {
      Fluttertoast.showToast(msg: "Password is too short!");
      _btnController.reset();
      return;
    }


    try{
      
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(), password: password)
        .onError((error, stackTrace) {
      _btnController.reset();
      Fluttertoast.showToast(msg: error.message);
     
    });
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).get();
      await FirebaseAuth.instance.currentUser.updateProfile(displayName: "${doc["name"]} *** ${doc["phone"]}", photoURL: doc["dp"], );
      
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Dashboard()  ), (route) => false);
        });
   

    
    }
    catch(e){
       _btnController.error();
      Fluttertoast.showToast(msg: e.message);
      Timer(Duration(seconds: 3), () {
        _btnController.reset();
      });
    }
  }
}
