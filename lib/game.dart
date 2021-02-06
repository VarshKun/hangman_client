import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/customProgressBar.dart';
import 'package:provider/provider.dart';
import 'dart:async';

//bool _hasBeenPressed = false;

class Game extends StatefulWidget {
  @override
  _Game createState() => _Game();
}

class _Game extends State<Game> {
  @override
  Widget build(BuildContext context) {
    //return WillPopScope(
    //onWillPop: () async => false ,
    return ChangeNotifierProvider(
      create: (context) => TimeState(),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              (Icons.timer),
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                              flex: 15,
                              child: Consumer<TimeState>(
                                  builder: (context, timeState, _) =>
                                      CustomProgressBar(
                                          335, timeState.time, 120)
                              )
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 15,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     color: Colors.white
                        //   ),
                        // ),
                        Expanded(
                            flex: 20,
                            child: Container(
                              child: Scrollbar(
                                thickness: 5,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 72,
                                      child: Card(
                                        color: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side: BorderSide(color: Colors.transparent)),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 25,
                                                    child: Image.asset(
                                                        'assets/avatars/default.png')),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Container(),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              'Empty',
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'NunitoBold',
                                                                  color: Colors
                                                                      .teal[50]),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              '0 pts',
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      'NunitoExtraLight',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .teal[50]),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child: Container(
                                                    //     color: Colors.white,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Consumer<TimeState>(
                                  builder: (context, timeState, _) =>
                                      FloatingActionButton.extended(
                                    backgroundColor:  Colors.yellow[700],
                                    focusColor: Colors.yellow[800],
                                    splashColor: Colors.yellow[800],
                                    elevation: 10,
                                    onPressed: () {
                                      
                                      Timer.periodic(Duration(seconds:1),
                                          (timer) {
                                        if (timeState.time == 0) {
                                          timer.cancel();
                                        }
                                        else {timeState.time -= 1;}
                                      });
                                    },
                                    label: Text(
                                            'START GAME',
                                            style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 7),
                                          ),
                                    //icon: Icon(Icons.copy),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: FloatingActionButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16)),
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.volume_up_rounded,
                                                size: 30,
                                              ),
                                              backgroundColor: Colors.yellow[700],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: FloatingActionButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16)),
                                              onPressed: () {},
                                              child: Icon(
                                                Icons.info_outline_rounded,
                                                size: 30,
                                              ),
                                              backgroundColor: Colors.yellow[700],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    //);
  }
}

class TimeState with ChangeNotifier {
  int _time = 120;
  int get time => _time;
  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }
}
