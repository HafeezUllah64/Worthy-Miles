import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worthymiles/constants.dart';

import '../size_config.dart';

class HeadingWidget extends StatelessWidget {
  final String text1;
  final String text2;
  HeadingWidget({this.text2, this.text1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 2),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(
                color: CustomColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Expanded(child: Container()),
          InkWell(
            onTap: (){
              Fluttertoast.showToast(msg: "Show All Tapped");
            },
                      child: Text(
              text2,
              style: TextStyle(
                  color: CustomColors.kLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
