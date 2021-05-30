import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../constants.dart';
import '../../Models/BloodRequest.dart';

class BloodForm extends StatefulWidget {
  @override
  _BloodFormState createState() => _BloodFormState();
}

class _BloodFormState extends State<BloodForm> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool visi = false;

  List<String> group = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];
  List<String> type = [
    "Whole Blood",
    "Platelets",
    "AB Plasma",
    "Double Red Cell",
    "Cord Blood",
    "I Don't know",
  ];

  List<String> reason = [
    "Accident",
    "Surgery",
    "Cancer",
    "Pregnancy",
    "Transplant",
    "Thalassemia",
    "Low HB(Hemoglobin)",
    "Other",
  ];

  int _groupValue = 1;
  int _typeValue = 1;
  int _reasonValue = 1;

  TextEditingController _medicalCenter = TextEditingController();
  TextEditingController _bloodBags = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.kLightPinkColor,
        title: Text("Post a Request"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(image: AssetImage("assets/donate_red.png")),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 45,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: TextField(
                    controller: _medicalCenter,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Medical Center',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 45,
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: TextField(
                    controller: _bloodBags,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Number of Bloof Bags Rquired',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Select Blood Group"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, right: 15, bottom: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: DropdownButton(
                      value: _groupValue,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      underline: SizedBox(),
                      hint: Text('Select Blood Type'),
                      items: [
                        DropdownMenuItem(child: Text(group[0]), value: 1),
                        DropdownMenuItem(child: Text(group[1]), value: 2),
                        DropdownMenuItem(child: Text(group[2]), value: 3),
                        DropdownMenuItem(child: Text(group[3]), value: 4),
                        DropdownMenuItem(child: Text(group[4]), value: 5),
                        DropdownMenuItem(child: Text(group[5]), value: 6),
                        DropdownMenuItem(child: Text(group[6]), value: 7),
                        DropdownMenuItem(child: Text(group[7]), value: 8),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Do you need whole blood or plaelets?"),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, right: 15, bottom: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: DropdownButton(
                      value: _typeValue,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      underline: SizedBox(),
                      hint: Text('Select Job Category'),
                      items: [
                        DropdownMenuItem(child: Text(type[0]), value: 1),
                        DropdownMenuItem(child: Text(type[1]), value: 2),
                        DropdownMenuItem(child: Text(type[2]), value: 3),
                        DropdownMenuItem(child: Text(type[3]), value: 4),
                        DropdownMenuItem(child: Text(type[4]), value: 5),
                        DropdownMenuItem(child: Text(type[5]), value: 6),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _typeValue = value;
                        });
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("What's the reason of this request? "),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, right: 15, bottom: 20),
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: DropdownButton(
                      value: _reasonValue,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      underline: SizedBox(),
                      hint: Text('Select Job Category'),
                      items: [
                        DropdownMenuItem(child: Text(reason[0]), value: 1),
                        DropdownMenuItem(child: Text(reason[1]), value: 2),
                        DropdownMenuItem(child: Text(reason[2]), value: 3),
                        DropdownMenuItem(child: Text(reason[3]), value: 4),
                        DropdownMenuItem(child: Text(reason[4]), value: 5),
                        DropdownMenuItem(child: Text(reason[5]), value: 6),
                        DropdownMenuItem(child: Text(reason[6]), value: 7),
                        DropdownMenuItem(child: Text(reason[7]), value: 8),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _reasonValue = value;
                        });
                      }),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20),
              //   child: Text("Are you posting this request for yourself?"),
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 15.0),
                      ]),
                  child: SwitchListTile(
                    title: Text(
                      'Are you posting this request for someone else?',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    value: visi,
                    activeColor: Colors.blue,
                    inactiveTrackColor: Colors.grey,
                    onChanged: (bool value) {
                      setState(() {
                        visi = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ),
              //aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: visi,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                          "Please specify his/her number for better reach "),
                    ),
                    Row(
                      children: [
                        CountryCodePicker(
                          initialSelection: "pk",
                          enabled: false,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '3457760349',
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RoundedLoadingButton(
                color: CustomColors.kLightPinkColor,
                width: MediaQuery.of(context).size.width * 0.8,
                child:
                    Text('    Post    ', style: TextStyle(color: Colors.white)),
                controller: _btnController,
                onPressed: () {
                  postRequest();
                },
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  postRequest() async {
    if (_medicalCenter.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please specify a medical Center");
      _btnController.reset();
      return;
    }
    if (_bloodBags.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter required blood bags");
      _btnController.reset();
      return;
    }
    if (visi && _phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please specify a phone number");
      _btnController.reset();
      return;
    }
    if (visi && _phoneController.text.trim().length != 10) {
      Fluttertoast.showToast(
          msg: "Please specify a correct number (e.g 3457760349)");
      _btnController.reset();
      return;
    }

    BloodRequest bloodRequest = BloodRequest(
      bloodBags: int.parse(_bloodBags.text.toString()),
      bloodGroup: group[_groupValue],
      bloodType: type[_typeValue],
      city: "ISLAMABAD",
      medicalCenter: _medicalCenter.text.trim(),
      phoneNumber: visi
          ? _phoneController.text.trim()
          : FirebaseAuth.instance.currentUser.displayName.split("***")[1],
      postedBy: FirebaseAuth.instance.currentUser.displayName.split("***")[0],
      reason: reason[_reasonValue],
      userID: FirebaseAuth.instance.currentUser.uid,
      userDp: FirebaseAuth.instance.currentUser.photoURL,
      bloodBagsArranged:  0
    );

    try {
      await FirebaseFirestore.instance
          .collection("Blood Requests")
          .doc()
          .set(bloodRequest.toMap());
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.message);
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
}
