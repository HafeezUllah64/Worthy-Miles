import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../Models/BloodRequest.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedBloodRequest extends StatefulWidget {
  final BloodRequest doc;
  const DetailedBloodRequest({Key key, @required this.size, @required this.doc})
      : super(key: key);

  final Size size;
  @override
  _DetailedBloodRequestState createState() => _DetailedBloodRequestState(doc);
}

class _DetailedBloodRequestState extends State<DetailedBloodRequest> {
  BloodRequest data;
  _DetailedBloodRequestState(this.data);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
bool byUser = false;
    @override
  void initState() {
    
    byUser = FirebaseAuth.instance.currentUser.uid == data.userID;
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                )),
                Text(
                  "Request Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.grey,
                  indent: 20,
                  endIndent: 20,
                )),
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage: data.userDp == "default"
                    ? AssetImage("assets/default_avatar.png")
                    : NetworkImage(data.userDp),
              ),
              title: Text(data.postedBy),
              subtitle: Text(data.phoneNumber.trimLeft()),
              trailing: IconButton(
                icon: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Icon(Icons.phone_enabled_rounded, color: Colors.green),
                ),
                onPressed: () {
                String phoneNumber = 'tel:${data.phoneNumber.substring(1)}';
                _launchCaller(phoneNumber);},
              ),
            ),
            Divider(
              height: 0,
              indent: widget.size.width * 0.18,
              color: Colors.grey,
            ),
             ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[200],
               child: Image.network("https://image.flaticon.com/icons/png/512/2760/2760618.png", height: 24, ),
              ),
              title: Text(data.reason),
              subtitle: Text("Emergency Type"),
             
            ),
            Divider(
              height: 0,
              indent: widget.size.width * 0.18,
              color: Colors.grey,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[100],
               child: Image.asset("assets/icons/blood.png", height: 24, color: Colors.red,),
              ),
              title: Text(data.bloodType),
              subtitle: Text("Request Type"),
             
            ),
            Divider(
              height: 0,
              indent: widget.size.width * 0.18,
              color: Colors.grey,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
               child: Icon(Icons.location_city_rounded),
              ),
              title: Text(data.city),
              subtitle: Text("City"),
             
            ),
            Divider(
              height: 0,
              indent: widget.size.width * 0.18,
              color: Colors.grey,
            ),
            SizedBox(height: 10,),
            
             RoundedLoadingButton(
              color: Colors.green,
              width: MediaQuery.of(context).size.width * 0.8,
              child: 
                  Text( byUser? '    View Requests    ' :'    Donate    ', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed:(){
                // loginUser(context);
                _btnController.success();
                Timer(Duration(seconds: 2), (){
                  _btnController.reset();
                });
              },
            ),
            // Expanded(child: Container(
              
            //   margin: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //   color: Colors.green,
            //     borderRadius: BorderRadius.circular(20)
            //   ),
            //   child: Text("Connect"),
            // ))
          ],
        ),
      ),
    );
  }

  _launchCaller(phoneNumber) async {
 
    if (await canLaunch(phoneNumber)) {
       await launch(phoneNumber);
    } else {
    
      Fluttertoast.showToast(msg: "Something Went Wrong!");
      throw 'Could not launch $phoneNumber';
    }   
}
}
