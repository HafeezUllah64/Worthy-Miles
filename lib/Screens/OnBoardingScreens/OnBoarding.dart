import 'package:flutter/material.dart';
import 'package:worthymiles/Dependencies/ConcentricPageView.dart';
import 'package:worthymiles/Screens/Authentication/Login/login_screen.dart';
import '../../Models/OnBoardingScreenModel.dart';
class OnBoarding extends StatelessWidget {
  final List<PageData> pages = [
    PageData(
      image: "walk",
      title: "Track your fitness\nactivities on go!",
      textColor: Colors.white,
      bgColor: Color(0xFFFDBFDD),
    ),
    PageData(
      image: "donate",
      title: "Donate blood, Save lives,\nBe a hero!",
      bgColor: Color(0xFFFFFFFF),
    ),
    PageData(
      image: "shop",
      title: "Redeem your fitness coins\nand get some awsome products!",
      bgColor: Color(0xFF0043D0),
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
          colors: colors,
//          opacityFactor: 1.0,
//          scaleFactor: 0.0,
          radius: 30,
          onFinish: (){
            print("DONE");
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> LoginScreen()
            ));
          },
          curve: Curves.ease,
          duration: Duration(seconds: 2),
//          verticalPosition: 0.7,
//          direction: Axis.vertical,
//          itemCount: pages.length,
//          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (index, value) {
            PageData page = pages[index % pages.length];
            // For example scale or transform some widget by [value] param
            //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
            return Container(
              child: Theme(
                data: ThemeData(
                  textTheme: TextTheme(
                    headline6: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Helvetica',
                      letterSpacing: 0.0,
                      fontSize: 17,
                    ),
                    subtitle2: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: PageCard(page: page),
              ),
            );
          },
        ),
      
    );
  }
}



class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPicture(context),
          SizedBox(height: 30),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 220,
    double iconSize = 170,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
        color: Colors.white, 
        //page.bgColor
//            .withBlue(page.bgColor.blue - 40)
            // .withGreen(page.bgColor.green + 20)
            // .withRed(page.bgColor.red - 100)
            // .withAlpha(90),
        image: DecorationImage(image: AssetImage("assets/${page.image}.png"))
      ),
      margin: EdgeInsets.only(
        top: 140,
      ),
      // child: Image.asset()
      //Stack(
      //   fit: StackFit.expand,
      //   children: <Widget>[
      //     Positioned.fill(
      //       child: RotatedBox(
      //         quarterTurns: 2,
      //         child: Icon(
      //           page.icon,
      //           size: iconSize + 20,
      //           color: page.bgColor
      //               .withBlue(page.bgColor.blue - 10)
      //               .withGreen(220),
      //         ),
      //       ),
      //       right: -5,
      //       bottom: -5,
      //     ),
      //     Positioned.fill(
      //       child: RotatedBox(
      //         quarterTurns: 5,
      //         child: Icon(
      //           page.icon,
      //           size: iconSize + 20,
      //           color: page.bgColor.withGreen(66).withRed(77),
      //         ),
      //       ),
      //     ),
      //     Icon(
      //       page.icon,
      //       size: iconSize,
      //       color: page.bgColor.withRed(111).withGreen(220),
      //     ),
      //   ],
      // ),
    );
  }
}