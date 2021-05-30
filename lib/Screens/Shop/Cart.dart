import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.02),
            child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.07),
            child: Text(
              "Cart",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: size.height * 0.06),
          ItemDetail(
              iamgePath: "assets/images/lays.png",
              text1: "Lay's",
              text2: "Lemon & Lime 500ml",
              size: size),
          SizedBox(height: size.height * 0.06),
          ItemDetail(
              iamgePath: "assets/images/fairyliquid.jpg",
              text1: "Fairy Original Liquid",
              text2: "Lemon & Lime 500ml",
              size: size),
          SizedBox(height: size.height * 0.06),
          ItemDetail(
              iamgePath: "assets/images/lays.png",
              text1: "Lay's",
              text2: "Lemon & Lime 500ml",
              size: size),
          SizedBox(height: size.height * 0.06),
          ItemDetail(
              iamgePath: "assets/images/fairyliquid.jpg",
              text1: "Fairy Original Liquid",
              text2: "Lemon & Lime 500ml",
              size: size),
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Container(
              height: size.height * 0.11,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/tracking.png",
                      color: Colors.white,
                    ),
                    Text(
                      "Our delivery\nis always free",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ]),
            ),
          ),
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Row(children: [
                  Image.asset("assets/images/coin.png", height: 22),
                  SizedBox(width: 5),
                  Text(
                    "20",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 22),
                  )
                ]),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.06),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
            ),
            child: GestureDetector(
              child: Container(
                height: size.height * 0.07,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.06),
        ]),
      ),
    );
  }
}

class ItemDetail extends StatelessWidget {
  const ItemDetail({
    Key key,
    @required this.size,
    @required this.text1,
    @required this.text2,
    @required this.iamgePath,
  }) : super(key: key);

  final Size size;
  final String text1;
  final String text2;
  final String iamgePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          height: size.height * 0.12,
          width: size.height * 0.12,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01, horizontal: size.height * 0.01),
            child: Image.asset(this.iamgePath),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            this.text1,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white70),
          ),
          Text(
            this.text2,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white70),
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            "1x",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.white30),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset("assets/images/coin.png", height: 22),
              SizedBox(width: 5),
              Text(
                "5",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 19),
              )
            ],
          )
        ])
      ]),
    );
  }
}
