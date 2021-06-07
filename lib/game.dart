import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
//import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/chatbox.dart';
import 'package:hangman_multiplayer/customProgressBar.dart';
import 'package:hangman_multiplayer/hangman_client.dart';
import 'package:hangman_multiplayer/starting_game.dart';
import 'package:hangman_multiplayer/waiting_status.dart';
//import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'avatarIndex.dart';
import 'exitDialog.dart';
import 'informationDialog.dart';

// ignore: must_be_immutable
class Game extends StatefulWidget {
  int _category;
  String pointsToWin;
  final String createGameResponse;
  //final String matchStatusResponse;
  String matchId;
  int avatarIndex;
  String playerId;
  final String _username;
  //String _playerId;
  String matchStatus;
  var parsed;

  //Text username = Text(usernameController.toString());
  Game(this._category, this.pointsToWin, this.createGameResponse,
      this.avatarIndex, this._username, this.playerId, this.matchId);

  @override
  _Game createState() => _Game(this._category, this.pointsToWin, _username,
      parsed, this.createGameResponse, this.avatarIndex, this.matchId);
}

class _Game extends State<Game> {
  final musicplayer = new AudioCache(fixedPlayer: AudioPlayer());
  //AudioCache audioCache = AudioCache();
  //var _firstPress = true ;
  int _category;
  String pointsToWin;
  final String username;
  int avatarIndex;
  bool playing = true;
  dynamic _parsed;
  var matchId;
  var playerId;
  List<String> wordlist;

  dynamic get parsedP {
    return _parsed;
  }

  set parsedP(dynamic parsed) {
    setState(() {
      _parsed = parsed;
    });
  }

  _Game(this._category, this.pointsToWin, this.username, parsed,
      String createGameResponse, this.avatarIndex, this.matchId) {
    if (playing) {
      musicplayer.loop('music/HangmanMusicMix.mp3');
    } else {
      musicplayer.fixedPlayer.pause();
    }
    if (_category != null) {
      try {
        final parsed = json.decode(createGameResponse);
        this.matchId = parsed['matchId'];
        tcpSend(joinGameHandler, errorHandler,
            "joinmatch/$matchId/$username/$avatarIndex");
        sleep(Duration(seconds: 5));
      } on FormatException catch (e) {
        print("That string didn't look like Json." + e.message);
      } on NoSuchMethodError catch (e) {
        print('That string was null!' + e.stackTrace.toString());
      }
    } else {
      try {
        tcpSend(matchStatusHandler, errorHandler, "matchstatus/$matchId");
      } on FormatException catch (e) {
        print("That string didn't look like Json." + e.message);
      } on NoSuchMethodError catch (e) {
        print('That string was null!' + e.stackTrace.toString());
      }
    }
  }
  void joinGameHandler(data) {
    String _data = new String.fromCharCodes(data).trim();
    try {
      final parsed = json.decode(_data);
      if (parsed['playerId'] != null) {
        this.playerId = parsed['playerId'];
      } else if (parsed['error'] != null) {
        print(parsed['error']);
      } else {
        print("Unknown error");
      }
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }
    try {
      tcpSend(matchStatusHandler, errorHandler, "matchstatus/$matchId");
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }
  }

  void matchStatusHandler(data) {
    String _data = new String.fromCharCodes(data).trim();
    try {
      parsedP = json.decode(_data);
      if (parsedP['Id'] != null) {
        parsedP["players"]
            .values
            .forEach((playerInfo) => {print("Value: $playerInfo")});
        pointsToWin = parsedP["maxscore"].toString();
        _category = parsedP["category"];
        var tempWordList = parsedP["wordlist"] as List;
        wordlist = tempWordList.map((word) => word as String).toList();
        // ignore: unnecessary_statements
        print('Value: $wordlist');
        Future.delayed(const Duration(milliseconds: 1500), () {
          tcpSend(matchStatusHandler, errorHandler, "matchstatus/$matchId");
        });
      } else if (parsedP['error'] != null) {
        print(parsedP['error']);
      } else {
        print("Unknown error");
      }
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }
  }

  void errorHandler(Object error, StackTrace trace) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider(
        create: (context) => TimeState(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue,
          body: Column(
            children: [
              Expanded(
                flex: 12,
                child: Container(
                    child: (() {
                  if (parsedP == null || parsedP['status'] == 0) {
                    return waitingStatus();
                  } else if (parsedP['status'] == 1) {
                    return starting_game(wordlist);
                  } else {
                    return InformationDialog(
                        21313, 'dropdownValue2', 'roomCode');
                  }
                }())),
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
                                            335, timeState.time, 120))),
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
                                    itemCount: parsedP == null
                                        ? 0
                                        : parsedP["players"].length,
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
                                                        AvatarIndices
                                                            .imgPaths
                                                            .elementAt(parsedP[
                                                                        "players"]
                                                                    .values
                                                                    .elementAt(
                                                                        index)[
                                                                "avatarIndex"])),
                                                  ),
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
                                                              child:
                                                                  Container(),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                parsedP["players"]
                                                                        .values
                                                                        .elementAt(
                                                                            index)[
                                                                    "name"],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'NunitoBold',
                                                                    color: Colors
                                                                            .teal[
                                                                        50]),
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
                                                                parsedP["players"]
                                                                        .values
                                                                        .elementAt(
                                                                            index)["score"]
                                                                        .toString() +
                                                                    " points",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        'NunitoExtraLight',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .teal[
                                                                        50]),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:
                                                                  Container(),
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
                                              flex: 10,
                                              child: FloatingActionButton(
                                                heroTag: null,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                onPressed: () async {
                                                  if (playing == true) {
                                                    setState(() {
                                                      playing = false;
                                                      musicplayer.fixedPlayer
                                                          .pause();
                                                    });
                                                  } else {
                                                    setState(() {
                                                      playing = true;
                                                      musicplayer.play(
                                                          'music/HangmanMusicMix.mp3');
                                                    });
                                                  }
                                                },
                                                child: playing
                                                    ? new Icon(
                                                        Icons.volume_up_rounded,
                                                        size: 30,
                                                      )
                                                    : new Icon(
                                                        Icons
                                                            .volume_off_rounded,
                                                        size: 30),
                                                backgroundColor:
                                                    Colors.yellow[700],
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
                                              flex: 10,
                                              child: FloatingActionButton(
                                                heroTag: null,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return InformationDialog(
                                                            _category,
                                                            pointsToWin,
                                                            matchId);
                                                      });
                                                },
                                                child: Icon(
                                                  Icons.info_outline_rounded,
                                                  size: 30,
                                                ),
                                                backgroundColor:
                                                    Colors.yellow[700],
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
                                              flex: 10,
                                              child: FloatingActionButton(
                                                heroTag: null,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return ExitDialog(
                                                            musicplayer);
                                                      });
                                                },
                                                child: Icon(
                                                  Icons.exit_to_app_rounded,
                                                  size: 30,
                                                ),
                                                backgroundColor:
                                                    Colors.yellow[700],
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
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 50,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              color: Color.fromRGBO(
                                                  10, 94, 251, 0.4),
                                              child: Chat(this.avatarIndex,
                                                  this.username),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              //color: Colors.cyan,
                                              ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  child: Container(
                                      //color: Colors.white,
                                      ),
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
            ],
          ),
        ),
      ),
    );
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
