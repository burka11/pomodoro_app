import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Pomodoro(),
  ));
}

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent=0;
  static int timeMinute=25;
  int timeSecond=timeMinute*60;

  Timer timer;
  _StartTimer(){
    timeMinute=25;
    int Time=timeMinute*60;
    double secPercent=(Time/100);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(Time>0){
          Time--;
          if(Time%60==0){
            timeMinute--;
          }
          if(Time%secPercent==0){
            if(percent<1){
              percent+=0.01;
            }
            else{
              percent=1;
            }
          }
        }
        else{
          percent=0;
          timeMinute=25;
          timer.cancel();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1542bf),Color(0xff51a8ff)],
            begin: FractionalOffset(0.5,1)
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:18.0),
              child: Text(
                "Pomodoro Uygulaması",
                style: TextStyle(
                  color: Colors.black, //TODO renk ile oyna
                  fontSize: 30.0

                ),
              ),
            ),
            Expanded(
              child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.square,
                percent:percent,
                animation:true,
                animateFromLastPercent:true,
                radius:240.0,
                lineWidth: 20.0,
                progressColor: Colors.green,
                backgroundColor: Colors.white,
                center:Text(
                  "$timeMinute",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 65.0
                  ),
                )

              ),
            ),
            SizedBox(height: 15.0,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Çalışma Zamanlayıcısı",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Text(
                                    "25",
                                    style: TextStyle(
                                      fontSize: 40.0,

                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Durdurma Zamanlayıcısı",
                                          style: TextStyle(
                                            fontSize: 25.0,
                                          ),
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text(
                                          "5",
                                          style: TextStyle(
                                            fontSize: 40.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 28.0),
                        child: RaisedButton(
                          onPressed: _StartTimer,
                          color:Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Çalışmaya başla",
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 25.0
                            ),)
                            ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}


