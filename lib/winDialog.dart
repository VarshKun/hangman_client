import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/avatarIndex.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class _winDialog extends State<winDialog> {
  int avatarIndex;
  String username;
  Map<String, dynamic> playerInfo;
  var sortedScores;

  _winDialog(this.avatarIndex, this.username, this.playerInfo) {
    var playerEntries = playerInfo.values.toList();
    sortedScores = playerEntries
      ..sort((a, b) => b['score'].compareTo(a['score']));
  }
  dialogContent(BuildContext context) {
    return Column(
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
                          'Winner: ' + sortedScores.elementAt(0)['name'],
                          style: TextStyle(
                              fontFamily: 'NunitoBold',
                              fontSize: 25,
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
                        radius: 30,
                        child: Image.asset(AvatarIndices.imgPaths.elementAt(
                            sortedScores.elementAt(0)['avatarIndex'])),
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
                                color: Colors.white,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.grey[900],
                                    child: Text(
                                      sortedScores.elementAt(0)['name'],
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize: 25,
                                          color: Colors.yellow[700],
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(3, 2),
                                                blurRadius: 3)
                                          ]),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
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
                                    '2 : ', //+ sortedScores.elementAt(1)['name'],
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.grey[900],
                                    child: Text(
                                      sortedScores.elementAt(1)['name'],
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize: 25,
                                          color: Colors.yellow[700],
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(3, 2),
                                                blurRadius: 3)
                                          ]),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
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
                                    '3 : ', //+ sortedScores.elementAt(3)['name'],
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.grey[900],
                                    child: Text(
                                      sortedScores.length > 2
                                          ? sortedScores?.elementAt(2)['name']
                                          : "",
                                      style: TextStyle(
                                          fontFamily: 'NunitoBold',
                                          fontSize: 25,
                                          color: Colors.yellow[700],
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(3, 2),
                                                blurRadius: 3)
                                          ]),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      // ),
      // elevation: 0.0,
      // backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

// ignore: camel_case_types
class winDialog extends StatefulWidget {
  final int avatarIndex;
  final String username;
  final Map<String, dynamic> playerInfo;

  winDialog(this.avatarIndex, this.username, this.playerInfo);

  @override
  _winDialog createState() => _winDialog(avatarIndex, username, playerInfo);
}
