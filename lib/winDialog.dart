import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/avatarIndex.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class _winDialog extends State<winDialog> {
  int avatarIndex;
  String username;
  _winDialog(this.avatarIndex, this.username);
  dialogContent(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: Container(
        height: 600,
        //color: Colors.white,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Container(
              color: Colors.lightBlue[50],
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          child: Stack(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: BorderedText(
                            strokeWidth: 3,
                            strokeColor: Colors.grey[900],
                            child: Text(
                              'Winner: ' + username,
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 35,
                                  color: Colors.yellow[700],
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(3, 2),
                                        blurRadius: 3)
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 55,
                            child: Image.asset(
                                AvatarIndices.imgPaths.elementAt(avatarIndex)),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Lottie.asset('assets/animations/win.json',
                              repeat: false),
                        ),
                      )
                    ],
                  ))),
                  Expanded(
                      child: Container(
                    //color: Colors.black,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          //color: Colors.black12,
                          child: BorderedText(
                            strokeWidth: 3,
                            strokeColor: Colors.grey[900],
                            child: Text(
                              'Ranks: ',
                              style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize: 30,
                                  color: Colors.yellow[700],
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(3, 2),
                                        blurRadius: 3)
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    //color: Colors.blue,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.grey[900],
                                      child: Text(
                                        '1 : ',
                                        style: TextStyle(
                                            fontFamily: 'NunitoBold',
                                            fontSize: 30,
                                            color: Colors.yellow[700],
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(3, 2),
                                                  blurRadius: 3)
                                            ]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.cyan,
                                  )),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          //color: Colors.blueAccent,
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    //color: Colors.blue,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.grey[900],
                                      child: Text(
                                        '2 : ',
                                        style: TextStyle(
                                            fontFamily: 'NunitoBold',
                                            fontSize: 30,
                                            color: Colors.yellow[700],
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(3, 2),
                                                  blurRadius: 3)
                                            ]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.cyanAccent,
                                  )),
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          //color: Colors.blue,
                          child: Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    //color: Colors.blue,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.grey[900],
                                      child: Text(
                                        '3 : ',
                                        style: TextStyle(
                                            fontFamily: 'NunitoBold',
                                            fontSize: 30,
                                            color: Colors.yellow[700],
                                            shadows: <Shadow>[
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(3, 2),
                                                  blurRadius: 3)
                                            ]),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.cyan,
                                  )),
                            ],
                          ),
                        )),
                      ],
                    ),
                  )),
                  // Expanded(
                  //     child: Container(
                  //   color: Colors.white,
                  // )),
                ],
              ),
            )),

            // Container(
            //   color: Colors.amber,
            //   child: Stack(
            //     children: [
            //       CircleAvatar(
            //         backgroundColor: Colors.transparent,
            //         radius: 55,
            //         child: Image.asset(
            //             AvatarIndices.imgPaths.elementAt(avatarIndex)),
            //       ),
            //       Lottie.asset('assets/animations/win.json', repeat: false),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

// ignore: camel_case_types
class winDialog extends StatefulWidget {
  final int avatarIndex;
  final String username;
  winDialog(this.avatarIndex, this.username);

  @override
  _winDialog createState() => _winDialog(avatarIndex, username);
}
