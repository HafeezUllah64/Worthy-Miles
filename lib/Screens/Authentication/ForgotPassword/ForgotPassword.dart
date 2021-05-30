import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Lottie.asset(
              'assets/Animations/email.json',
              
              controller: _controller,
              
              animate: false,
             height: 250,
              onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                 _controller.stop();
                _controller
                  ..duration = composition.duration
                  ;
              },
            ),
              Container(
                height: 60,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 10)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                    child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      focusColor: kPrimaryColor,
                      border: InputBorder.none,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email)),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your email and we will send you a link to reset your password",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.all(20),
                color: Color(0xFF7380C5),
                onPressed: () {
                  sendResetLink(context);
                },
                shape: CircleBorder(),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendResetLink(context) async {

    if (_emailController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter a valid email",
      );
      return;
    }
    if (!_emailController.text.contains("@") ||
        !_emailController.text.contains(".com")) {
      Fluttertoast.showToast(
        msg: "Please enter a valid email",
      );
      return;
    }
    _controller.forward();

    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
    Fluttertoast.showToast(msg: "Reset Link sent");
    _emailController.clear();
  }
}
