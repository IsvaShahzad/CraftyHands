import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_services_flutter/Consumer_Screens/Consumer_mainpage.dart';
import 'package:home_services_flutter/seller/SellerMainPage.dart';
import 'package:provider/provider.dart';

import '../initialScreens/loginScreen.dart';
import 'favourites.dart';

class ExploreConsumer extends StatefulWidget {
  @override
  State<ExploreConsumer> createState() => _ExploreConsumerState();
}

class _ExploreConsumerState extends State<ExploreConsumer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/lb.png"), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 13,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            title: Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Container(
            child: Form(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 240.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text('Explore Consumer ',
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    minimumSize: const Size(180, 50),
                                    maximumSize: const Size(180, 50),
                                    primary: Color(0xFFAB47BC),
                                    onPrimary: Colors.white,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConsumerMainPageScreen(

                                                )));
                                  },
                                  child: const Text(
                                    'Next ',
                                  )),
                            )
                          ]),
                    ))),
          )),
    );
  }
}
