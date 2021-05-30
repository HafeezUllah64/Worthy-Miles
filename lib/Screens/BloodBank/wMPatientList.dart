import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'bloodform.dart';
import 'DetailedBloodRequest.dart';

import '../../Models/BloodRequest.dart';
class PatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height:  MediaQuery.of(context).size.height,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
         
          SizedBox(height: 10),
          Center(
            child: Container(
              height: size.height * 0.22,
              width: size.width * 0.88,
              decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                      ),
                      child: Text(
                        "Loacation",
                        style: TextStyle(color: Colors.white54, fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.07, right: size.width * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ISLAMABAD",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.location_on,
                            color: Colors.red[300],
                          )
                        ],
                      ),
                    ),
                      Padding(
                        padding:  EdgeInsets.only(
                          left: size.width * 0.07, right: size.width * 0.07),
                        child: Divider(height: 10, thickness: 1,
                        color: Colors.white24,),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.07, right: size.width * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "change your blood group",
                            style: TextStyle(color: Colors.white54, fontSize: 10),
                          ),
                          Container(
                            height: size.width * 0.08,
                            width: size.width * 0.11,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[600]),
                            child: Center(
                              child: Text(
                                "A+",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ]),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Card(
            elevation: 5,
                    child: ListTile(
              
            leading: CircleAvatar(
              
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage("https://image.flaticon.com/icons/png/512/3022/3022802.png"),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BloodForm()  ));
            },
              title: Text("Request Blood"),
              subtitle: Text("Fill the form to post a request"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.06, right: size.width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PatientList",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black26),
                ),
                IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.black26,
                      size: 18,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
         Expanded(child: 
          StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Blood Requests").where("city", isEqualTo: "ISLAMABAD",).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData && snapshot.data !=null){

                return ListView(

                  children: snapshot.data.docs.map((doc) {
                    return PatientData(size: size, doc: doc);
                  }).toList(),
                );
              } 
              else{
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                else{
                  return Center(child: Text("No request found for the specified Area"));
                }
              } 
            },
          ),
         ),
         
        ]),
      ),
    ));
  }
}

class PatientData extends StatelessWidget {
  final DocumentSnapshot doc;
  const PatientData({
    Key key,
    @required this.size,
    @required this.doc
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          showModalBottomSheet(
            
            backgroundColor: Colors.transparent,
            context: context, builder: (context){
            BloodRequest bReq = BloodRequest.fromMap(doc.data());
            return DetailedBloodRequest(size : size, doc: bReq);
          });
      },
          child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.02),
          height: size.height * 0.41,
          width: size.width * 0.88,
          decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(20)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(

                    )),
                     Container(
                        width: size.width * 0.14,
                        height: size.width * 0.14,
                        margin: EdgeInsets.only(
                          top: 20,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:doc["userDp"] == "default" ?  AssetImage("assets/default_avatar.png"): NetworkImage(
                                doc["userDp"]),
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    //SizedBox(width: size.width * 0.23),
                    Expanded(
                      
                      flex: 2,
                      child: Container()),
                    Text(
                      
                      "# ${doc.id.hashCode.toString().substring(0, 4)}",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(width: size.width * 0.05),
                  ],
                ),
                Text(
                  doc['postedBy'],
                  style: TextStyle(color: Colors.black, fontSize: 14,
                  fontWeight: FontWeight.w900),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red[300],
                    ),
                    Text(
                      doc["medicalCenter"],
                      style: TextStyle(color: Colors.black,
                       fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                            height: size.height * 0.12,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  doc['bloodGroup'],
                                  style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 14,
                                  ),
                                ),
                                Divider(height: 10, thickness: 1),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        doc["bloodBagsArranged"].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "/${doc["bloodBags"].toString()}",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ]),
                              ],
                            )),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: size.height * 0.22,
                        width: size.width * 0.46,
                        // color: Colors.brown,

                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              showLabels: false,
                              showTicks: false,
                              startAngle: -270,
                              maximum: double.parse(doc["bloodBags"].toString()),
                              minimum: 0,
                              endAngle: -270,
                              radiusFactor: 0.7,
                              canScaleToFit: true,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.05,
                                color: Colors.black12,
                                thicknessUnit: GaugeSizeUnit.factor,
                                cornerStyle: CornerStyle.startCurve,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                    value: double.parse(doc["bloodBagsArranged"].toString()),
                                    width: 0.05,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    cornerStyle: CornerStyle.startCurve,
                                    gradient: SweepGradient(colors: <Color>[
                                      Colors.red[200],
                                      Colors.red[200]
                                    ], stops: <double>[
                                      0.25,
                                      0.75
                                    ])),
                                MarkerPointer(
                                  value: double.parse(doc["bloodBagsArranged"].toString()),
                                  markerType: MarkerType.circle,
                                  color: Colors.red[200],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
