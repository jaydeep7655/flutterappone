import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterappone/home.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => homepage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Text(
          "Quister\nTest Yourself..",
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.white,
            fontFamily: "Quando",
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
