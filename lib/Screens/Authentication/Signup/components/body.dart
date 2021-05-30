import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:worthymiles/Screens/Authentication/Login/login_screen.dart';
import 'package:worthymiles/Screens/Authentication/Signup/components/background.dart';
import 'package:worthymiles/Screens/Authentication/Signup/components/or_divider.dart';
import 'package:worthymiles/Screens/Dashboard/Dashboard.dart';
import 'package:worthymiles/components/already_have_an_account_acheck.dart';
import 'package:worthymiles/components/rounded_button.dart';
import 'package:worthymiles/components/rounded_input_field.dart';
import 'package:worthymiles/components/rounded_password_field.dart';
import 'package:worthymiles/components/text_field_container.dart';
import 'package:worthymiles/constants.dart';

class Body extends StatelessWidget {
  String name = '';
  String email = "";
  String password = '';
    String phone = '';

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Lottie.asset("assets/Animations/login.json", height: 200),
            RoundedInputField(
              icon: Icons.person,
              iconColor: kSignupColor,
              hintText: "Name",
              onChanged: (value) {
                name = value;
              },
            ),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                keyboardType: TextInputType.phone,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone_enabled_rounded,
                    color: kSignupColor,
                  ),
                  hintText: "Phone",
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedInputField(
              icon: Icons.email_rounded,
              iconColor: kSignupColor,
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              iconColor: kSignupColor,
              hint: "Password",
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedLoadingButton(
              color: kSignupColor,
              width: MediaQuery.of(context).size.width * 0.8,
              child:
                  Text('    SIGNUP    ', style: TextStyle(color: Colors.black)),
              controller: _btnController,
              onPressed: () {
                signupUser(context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pop(context);
              },
            ),SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }

  signupUser(context) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill the credentials properly!");
      _btnController.reset();
      return;
    } if (phone.length != 11) {
      Fluttertoast.showToast(
          msg: "Invalid phone Number (e.g : 0300XXXXXXX )");
      _btnController.reset();
      return;
    }
    if (!email.contains("@") || !email.contains(".com")) {
      Fluttertoast.showToast(msg: "Enter a valid Email Address");
      _btnController.reset();
      return;
    }

    if (password.length < 8) {
      Fluttertoast.showToast(msg: "Password is too short");
      _btnController.reset();
      return;
    }

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.message);
        _btnController.error();
        Timer(Duration(seconds: 2), () {
          _btnController.reset();
        });
      }).whenComplete(() async {
        String userID = FirebaseAuth.instance.currentUser.uid;
        await FirebaseFirestore.instance.collection("Users").doc(userID).set({
          "name": name,
          "email": email,
          "phone" : phone,
          "dp" : "default",
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            (route) => false);
      });
    } catch (e) {
      _btnController.error();
      Fluttertoast.showToast(msg: e.message);
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });
    }
  }
}
