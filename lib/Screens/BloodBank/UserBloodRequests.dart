import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'wMPatientList.dart';

class UserBloodRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("My Requests")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Blood Requests")
              .where(
                "userID",
                isEqualTo: FirebaseAuth.instance.currentUser.uid,
              )
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                children: snapshot.data.docs.map((doc) {
                  return PatientData(size: size, doc: doc);
                }).toList(),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                    child: Text("No request found for the specified Area"));
              }
            }
          },
        ),
      ),
    );
  }
}
