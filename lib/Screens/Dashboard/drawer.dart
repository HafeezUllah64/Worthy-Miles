import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worthymiles/Screens/BloodBank/wMPatientList.dart';
import 'package:worthymiles/Screens/BloodBank/bloodform.dart';
import 'package:worthymiles/Screens/Dashboard/Profile/Profile.dart';
import 'package:worthymiles/Screens/Shop/Cart.dart';
import 'package:worthymiles/constants.dart';

import '../Authentication/Login/login_screen.dart';
import '../BloodBank/UserBloodRequests.dart';

class Navbar extends StatelessWidget {
  Navbar({Key key}) : super(key: key);
  static const kPrimaryColor = Color(0xFF6F35A5);
  static const kPrimaryLightColor = Color(0xFFF1E6FF);
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: CustomColors.kLightPinkColor),
            accountName: Text(user.displayName.split("***")[0]),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage:
                  //user.photoURL == "default" ?
                  AssetImage("assets/default_avatar.png")
              //: NetworkImage(user.photoURL)
              ,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            leading: Icon(
              Icons.person,
              size: 20,
            ),
            title: Text(
              "Profile Setting",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
            leading: Icon(
              Icons.shopping_cart_rounded,
              size: 20,
            ),
            title: Text(
              "Cart",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.shopping_bag_rounded,
              size: 20,
            ),
            title: Text(
              "Shop",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.stacked_line_chart_outlined,
              size: 20,
            ),
            title: Text(
              "Offers & Promotions",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.feedback_rounded,
              size: 20,
            ),
            title: Text(
              "Feedback",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.history_rounded,
              size: 20,
            ),
            title: Text(
              "Blood Donnation History",
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserBloodRequests()));
            },
            leading: Icon(
              Icons.remove_from_queue_rounded,
              size: 20,
            ),
            title: Text(
              "My Blood Requests",
              style: TextStyle(fontSize: 15),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              });
            },
            leading: Icon(
              Icons.logout,
              size: 20,
            ),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
