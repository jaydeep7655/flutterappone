import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Timer",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timeToDisplay = "";
  bool started = true;
  bool stopped = true;
  int timefortimer;
  bool cancelTimer = false;
  final dur = const Duration(seconds: 1);

  @override
  void initState() {
    // TODO: implement initState
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (timefortimer < 1 || cancelTimer == true) {
          t.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        } else if (timefortimer < 60) {
          timeToDisplay = timefortimer.toString();
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timeToDisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      cancelTimer = true;
      timeToDisplay = "";
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "HH",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        listViewWidth: 60.0,
                        maxValue: 23,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "MM",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        listViewWidth: 60.0,
                        maxValue: 23,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        })
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: Text(
                        "SS",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        listViewWidth: 60.0,
                        maxValue: 23,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        })
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timeToDisplay,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: started ? start : null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  RaisedButton(
                    onPressed: stopped ? null : stop,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      "Stop",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  //===========================================================
  //===========================================================
  //===========================================================
  //                  the stopWatch Code
  //===========================================================
  //===========================================================
  //===========================================================

  bool startisPressed = true;
  bool stopisPressed = true;
  bool resetisPressed = true;

  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur1 = const Duration(seconds: 1);


  void startTimer() {
  Timer(dur,keeprunning);
  }

  void keeprunning(){
    if(swatch.isRunning){
      startTimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2,"0") + ":"
      + (swatch.elapsed.inMinutes % 60).toString().padLeft(2,"0") + ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2,"0");

    });

  }

  void startstopwatch() {
    setState(() {
      stopisPressed = false;
      startisPressed=false;
    });
    swatch.start();
    startTimer();
  }

  void stopstopwatch() {
    setState(() {
      stopisPressed=true;
      resetisPressed=false;
    });
    swatch.stop();

  }

  void resetstopwatch() {
    setState(() {
      startisPressed= true ;
      resetisPressed =true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  Widget stopWatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: stopisPressed ? null : stopstopwatch,
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        RaisedButton(
                          onPressed: resetisPressed ? null : resetstopwatch,
                          color: Colors.teal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    RaisedButton(
                      onPressed: startisPressed ? startstopwatch : null,
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 80.0,
                        vertical: 20.0,
                      ),
                      child: Text(
                        "Start",
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watch"),
        centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[Text("Timer"), Text("StopWatch")],
          controller: tb,
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          unselectedLabelColor: Colors.white60,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopWatch(),
        ],
        controller: tb,
      ),
      backgroundColor: Colors.white,
    );
  }
}
