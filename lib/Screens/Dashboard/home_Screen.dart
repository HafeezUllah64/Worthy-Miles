import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:worthymiles/Screens/Dashboard/activity_screen.dart';
import 'package:worthymiles/Screens/Dashboard/dashboard_screen.dart';
import 'package:worthymiles/Screens/Dashboard/drawer.dart';
import 'package:worthymiles/Screens/Dashboard/metric_screen.dart';
import 'package:worthymiles/constants.dart';

import '../../size_config.dart';
import '../BloodBank/wMPatientList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int _currentIndex = 0;
  PageController _pageController = PageController();
  final tabs = [
    DashboardScreen(),
    ActivityScreen(),
    MetricScreen(),
    PatientList(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This is to instantiate the class responsible for Responsive UI
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        elevation: 0,
        title:  Text(
                "Worthy Miles",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red[300]),
              ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "Notifications Tapped!");
              },
              child: Icon(
                Icons.notifications,
                size: 30,
                 color:  Colors.red[300],
              ),
             
            ),
          )
        ],
      ),
      drawer: Navbar(),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (val) {
          setState(() {
            _currentIndex = val;
          });
        },
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
            // setState(() {
            //   _currentIndex = index;
            // });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/apps.svg',
                height: 30,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: SvgPicture.asset('assets/icons/apps.svg',
                  height: 30, color: CustomColors.kPrimaryColor),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/clock.svg',
                height: 30,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: SvgPicture.asset('assets/icons/clock.svg',
                  height: 30, color: CustomColors.kPrimaryColor),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/stats.svg',
                height: 30,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: SvgPicture.asset('assets/icons/stats.svg',
                  height: 30, color: CustomColors.kPrimaryColor),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/blood.png',
                height: 30,
                color: Colors.grey,
              ),
              label: "",
              activeIcon: Image.asset('assets/icons/blood.png',
                  height: 30, color: CustomColors.kPrimaryColor),
            ),
          ]),
    );
  }
}
