import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/chatbox.dart';
import 'package:hangman_multiplayer/customProgressBar.dart';
import 'package:hangman_multiplayer/hangman_client.dart';
import 'package:hangman_multiplayer/inviteDialog.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'exitDialog.dart';
import 'informationDialog.dart';
import 'package:audioplayers/audio_cache.dart';


// ignore: must_be_immutable
class Game extends StatefulWidget {
  final int _category;
  final String pointsToWin;
  final String createGameResponse;
  final String matchStatusResponse;
  String matchId;
  int avatarIndex;
  String playerId;
  final String _username;
  String _playerId;
  String matchStatus;
 
  //Text username = Text(usernameController.toString());
  Game(this._category, this.pointsToWin, this.createGameResponse, this.avatarIndex, this._username, this._playerId,this.matchStatusResponse){
    if (_category != null){
      try {
        final parsed = json.decode(createGameResponse); 
        this.matchId = parsed['matchId'];
        tcpSend(joinGameHandler, errorHandler,"joinmatch/$matchId/$_username/$avatarIndex");
      } on FormatException catch (e) {
        print("That string didn't look like Json." + e.message);
      } on NoSuchMethodError catch (e) {
        print('That string was null!' + e.stackTrace.toString());
      }    
    }
    else {
      try {
        tcpSend(matchStatusHandler, errorHandler,"matchstatus/$matchId");
      } on FormatException catch (e) {
        print("That string didn't look like Json." + e.message);
      } on NoSuchMethodError catch (e) {
        print('That string was null!' + e.stackTrace.toString());
      }       
    }

  }
  
  void joinGameHandler(data){
    String _data = new String.fromCharCodes(data).trim();
    try {
      final parsed = json.decode(_data);
      if (parsed['playerId'] != null){
        this.playerId = parsed['playerId'];
      }
      else if(parsed['error'] != null){
        print(parsed['error']);
      }
      else{
        print("Unknown error");
      }
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    } 
    try {
      tcpSend(matchStatusHandler, errorHandler,"matchstatus/$matchId");
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }       
    
  }
  void matchStatusHandler(data){
    String _data = new String.fromCharCodes(data).trim();
    try {
        final parsed = json.decode(_data); 
        if (parsed['json'] != null){
          this.matchStatus = parsed['json'];
        }
        else if(parsed['error'] != null){
          print(parsed['error']);
        }
        else{
          print("Unknown error");
        }
      } on FormatException catch (e) {
        print("That string didn't look like Json." + e.message);
      } on NoSuchMethodError catch (e) {
        print('That string was null!' + e.stackTrace.toString());
      }    
  }
  void errorHandler(Object error, StackTrace trace){
    print(error);
  }
  
  @override
  _Game createState() => _Game(_category,pointsToWin,_username);
}

class _Game extends State<Game> {
  final musicplayer = new AudioCache(fixedPlayer: AudioPlayer());
  //AudioCache audioCache = AudioCache();
  //var _firstPress = true ;
  final int _category;
  final String pointsToWin;
  final String username;
  bool playing = true;
  _Game(this._category,this.pointsToWin, this.username);  
  @override
  Widget build(BuildContext context) {
    if(playing ){
      musicplayer.loop('music/hangman-music.mp3');
    }
    else{
      musicplayer.fixedPlayer.stop();
    }
    //audioCache.loop('music/hangman-music.mp3');
    return WillPopScope(
    onWillPop: () async => false ,
    child: ChangeNotifierProvider(
      create: (context) => TimeState(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                color:Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              flex:2,
                              child:Container(
                                
                              )
                            ),
                            Expanded(
                              child: BorderedText(
                                strokeWidth: 3,
                                strokeColor: Colors.grey[900],
                                child: Text(
                                  'WAITING',
                                  style: TextStyle(
                                    fontFamily: 'NunitoBold',
                                    fontSize: 20,
                                    color: Colors.yellow[700],
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        offset: Offset(3,2),
                                        blurRadius: 3
                                      )
                                    ]
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child: Lottie.asset(
                          'assets/animations/waiting_pigeon.json',
                          width: 400,
                          height: 200
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child:Text(
                                'WAITING FOR PLAYERS',
                                style: TextStyle(
                                  fontFamily: 'NunitoBold',
                                  fontSize:14,
                                  color: Colors.blueGrey[600]
                                ),
                              )
                            ),
                            Expanded(
                              flex:2,
                              child:Container(
                                
                              )
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
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
                              // Expanded(
                              //   child: Consumer<TimeState>(
                              //     builder: (context, timeState, _) =>
                              //         FloatingActionButton.extended(
                              //       backgroundColor:  Colors.yellow[700],
                              //       focusColor: Colors.yellow[800],
                              //       splashColor: Colors.yellow[800],
                              //       elevation: 10,
                              //       onPressed: () async{
                              //         if (_firstPress){
                              //           _firstPress = false;
                              //           Timer.periodic(Duration(seconds:1),
                              //             (timer) {
                              //               if (timeState.time == 0) {
                              //                 timer.cancel();
                              //               }
                              //               else {timeState.time -= 1;}
                              //             });
                              //         }
                                      
                              //       },
                              //       label: Text(
                              //               'START GAME',
                              //               style: TextStyle(
                              //                   fontFamily: 'NunitoBold',
                              //                   color: Colors.black,
                              //                   fontWeight: FontWeight.w900,
                              //                   fontSize: 6),
                              //             ),
                              //       //icon: Icon(Icons.copy),
                              //     ),
                              //   ),
                              // ),
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
                                                      BorderRadius.circular(16)),
                                              onPressed: () async{
                                                if (playing == true){
                                                  setState(() {
                                                    playing = false; 
                                                    musicplayer.fixedPlayer.stop();
                                                    //audioCache.loop('music/hangman-music.mp3');              
                                                  });
                                                }
                                                else{
                                                  setState(() {
                                                    playing = true; 
                                                    musicplayer.play('music/hangman-music.mp3');
                                                    //audioCache.loop('music/hangman-music.mp3',mode: PlayerMode.LOW_LATENCY); 
                                                    //audioCache.fixedPlayer.stop();    
                                                                                                 
                                                  });
                                                }
                                              },
                                              child: playing?new Icon(
                                                Icons.volume_up_rounded,
                                                size: 30,
                                              ): new Icon(
                                                Icons.volume_off_rounded,
                                                size: 30
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
                                            flex: 10,
                                            child: FloatingActionButton(
                                              heroTag: null,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16)),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return InformationDialog(_category,pointsToWin,matchId);                                                                  
                                                    }                                                                 
                                                );
                                              },
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
                                                      BorderRadius.circular(16)),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return ExitDialog(musicplayer);                                                                  
                                                    }                                                                 
                                                );
                                              },
                                              child: Icon(
                                                Icons.exit_to_app_rounded,
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
                                child:Row(
                                  children: [
                                    Expanded(
                                      flex: 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: Color.fromRGBO(10,94,251,0.4),
                                          child: Chat(),
                                        ),
                                      ),
                                    ),
                                     Expanded(
                                      child: Container(
                                        //color: Colors.cyan,
                                      ),
                                    ),
                                  ],
                                )
                                
                              ),
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
