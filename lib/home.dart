import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

Widget customcard() {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 20.0,
      horizontal: 30.0,
    ),
    child: Material(
      elevation: 10.0,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: ClipOval(
                child: Image(
                    image:AssetImage(
                      "images/py.png"
                    ) ,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          customcard(),
        ],
      ),
    );
  }
}
