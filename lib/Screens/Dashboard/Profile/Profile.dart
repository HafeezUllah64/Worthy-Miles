import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:worthymiles/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedRadio;
  int selectedRadioTile;
  File file;
  DateTime _currentdate = new DateTime.now();

  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
    }
  }

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2020),
        builder: (context, child) {
          return SingleChildScrollView(
            child: child,
          );
        });
    if (_seldate != null) {
      setState(() {
        _currentdate = _seldate;
      });
    }
  }
  
  TextEditingController name = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;

    name..text = FirebaseAuth.instance.currentUser.displayName.split("***")[0].trim();
    phoneNumber..text = FirebaseAuth.instance.currentUser.displayName.split("***")[1].trimLeft();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();


  Widget build(BuildContext context) {
    // String _formattedate = new DateFormat.yMMMd().format(_currentdate);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: CustomColors.kLightPinkColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    child: Stack(
                      children: [
                        Container(
                          height: 95,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: file == null
                                      ? NetworkImage(
                                          "https://image.flaticon.com/icons/png/512/847/847969.png")
                                      : FileImage(file))),
                        ),
                        Positioned(
                            left: 70,
                            top: 70,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5.0,
                                        spreadRadius: 5),
                                  ]),
                              child: Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 15.0),
                                    ]),
                                child: IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  icon: Image.asset("assets/cam.png"),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Your Name ",
                  style: TextStyle(fontSize: 13, color: Color(0xFF022950)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Color(0xFFF0F3FD),
                  ),
                  child: TextField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        hintText: "User Name",
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Enter Your Mobile Number",
                  style: TextStyle(fontSize: 13, color: Color(0xFF022950)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.05,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Color(0xFFF0F3FD),
                  ),
                  child: TextField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: "+92 333 5551111",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, top: 10),
              //   child: Text(
              //     "Date of Birth ",
              //     style: TextStyle(fontSize: 13, color: Color(0xFF022950)),
              //   ),
              // ),
              // Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         _selectdate(context);
              //       },
              //       icon: Icon(Icons.calendar_today),
              //     ),
              //     Center(child: Text('Date: $_formattedate '))
              //   ],
              // ),
              // Container(
              //   child: ButtonBar(
              //     alignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         width: 120,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.grey),
              //             color: Color(0xFFF0F3FD),
              //             borderRadius: BorderRadius.circular(15)),
              //         child: Row(
              //           children: [
              //             Text("       Male"),
              //             Radio(
              //               value: 1,
              //               groupValue: selectedRadio,
              //               activeColor: Colors.green,
              //               onChanged: (val) {
              //                 print("Radio $val");
              //                 setSelectedRadio(val);
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //       Container(
              //         width: 125,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.grey),
              //             color: Color(0xFFF0F3FD),
              //             borderRadius: BorderRadius.circular(15)),
              //         child: Row(
              //           children: [
              //             Text("       Female"),
              //             Radio(
              //               value: 1,
              //               groupValue: selectedRadio,
              //               activeColor: Colors.green,
              //               onChanged: (val) {
              //                 print("Radio $val");
              //                 setSelectedRadio(val);
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // )
              RoundedLoadingButton(
                color: kPrimaryColor,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text('    Update    ',
                    style: TextStyle(color: Colors.white)),
                controller: _btnController,
                onPressed: () {
                  // loginUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateUserProfile() async {
    String url = "default";

    try{
      
    if(file!=null){
 FirebaseStorage storage = FirebaseStorage.instance;
//Create a reference to the location you want to upload to in firebase
Reference reference = storage.ref().child("profileImages/${FirebaseAuth.instance.currentUser.uid}");
UploadTask uploadTask = reference.putFile(file);
    
        TaskSnapshot taskSnapshot = await uploadTask;
    
        // Waits till the file is uploaded then stores the download url
         url = await taskSnapshot.ref.getDownloadURL();
    }
    
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({

      "name": name.text.trim(),
      "phone":phoneNumber.text.trim(),
      "dp":url,

    });
    await FirebaseAuth.instance.currentUser.updateProfile(displayName: "${name.text.trim()} *** ${phoneNumber.text.trim()}", photoURL: url,);
    _btnController.success();
    Timer(
      Duration(seconds: 2),
      (){
        _btnController.reset();
        Navigator.pop(context);
      }

    );
    
   

    }
    catch(e){
      _btnController.error();
      Fluttertoast.showToast(msg: e.message);
   Timer(
      Duration(seconds: 2),
      (){
        _btnController.reset();
        Navigator.pop(context);
      });
    }


 
  }
}
