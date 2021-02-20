import 'dart:convert';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:hangman_multiplayer/teddy_controller.dart';
import 'package:hangman_multiplayer/tracking_text_input.dart';
import 'hangman_client.dart';
import 'join_game.dart';



// ignore: must_be_immutable
class JoinRoom extends StatefulWidget{
  final String _username;
  final int _avatarIndex;
  //final String joinGameResponse;
 
  JoinRoom(this._avatarIndex, this._username);
  
  @override
   _JoinRoom createState() => _JoinRoom(_avatarIndex,_username);

   
}

class _JoinRoom extends State<JoinRoom>{
  String _matchId;
  String playerId;
  String animationType = "idle";
  TeddyController _teddyController;
  int avatarIndex;
  String username;
  _JoinRoom(this.avatarIndex, this.username);
  @override
  void initState() { 
    _teddyController = TeddyController();
    super.initState();
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
  }

  void errorHandler(Object error, StackTrace trace){
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      //body: WillPopScope(
        //onWillPop: ()  async => false,
      body: Column(
        children:[
          Expanded(
            flex:2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container
                            (
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row
                            (
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_back_rounded),
                                              onPressed: (){
                                                Navigator.pop(context);
                                                //Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen() ));
                                              },
                                              color: Colors.yellow[700],
                                              iconSize: 35
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Text(
                                                'BACK',
                                                style: TextStyle(
                                                  fontFamily: 'PumpkinCheesecake',
                                                  fontSize: 30,
                                                  color: Colors.yellow[700]
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],)
                                ),
                                Expanded(
                                  flex: 10,
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.grey[900],
                                    child: Text(
                                      'JOIN ROOM',
                                      style: TextStyle(
                                        fontFamily: 'NunitoBold',
                                        fontSize: 40,
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
                                Expanded(
                                  flex: 2,
                                  child: Container
                                  (
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container
                            (
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
          ),
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                      color: Colors.blue
                    ),
                ),
                Expanded(
                  flex: 22,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.white, //white box
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(color: Colors.white,),
                          ),
                          Expanded(
                            flex: 3,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.white,
                              child: new FlareActor(
                                "assets/animations/teddy.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: animationType,
                                controller: _teddyController,
                              ),
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
                                        child: Container(color: Colors.cyan),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: TrackingTextInput(
                                          onTextChanged: (String value){
                                            _teddyController.matchId(value);
                                          },
                                          hint: "Enter room code here",
                                          onCaretMoved: (Offset caret){
                                            _teddyController.lookAt(caret);
                                          },
                                        ),
                                        // child: TextFormField(
                                        //   focusNode: roomCodeFocusNode,
                                        //   controller: roomCodeController,
                                        //   decoration: InputDecoration(
                                        //     focusedBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(
                                        //         color: Colors.black,
                                        //         width: 1,
                                        //       ),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //     ),
                                        //     enabledBorder: OutlineInputBorder(
                                        //       borderSide:
                                        //           BorderSide(color: Colors.black, width: 1),
                                        //       borderRadius: BorderRadius.circular(10),
                                        //     ),
                                        //     hintText: "Room code:"
                                        //   ),
                                        // ),
                                      ),
                                      Expanded(
                                        child: Container(color: Colors.cyan),
                                      ),
                                    ],
                                  )
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex:2,
                                              child: JoinGameButton(
                                                child:Text(
                                                  "JOIN GAME",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'PumpkinCheesecake',
                                                    fontSize: 35,
                                                    color: Colors.white
                                                  ),
                                                ),
                                                onPressed: (){
                                                  //_teddyController.submitMatchId();
                                                  _matchId = _teddyController.submitMatchId();
                                                  try {
                                                    tcpSend(joinGameHandler, errorHandler,"joinmatch/$_matchId/$username/$avatarIndex");
                                                  } on FormatException catch (e) {
                                                    print("That string didn't look like Json." + e.message);
                                                  } on NoSuchMethodError catch (e) {
                                                    print('That string was null!' + e.stackTrace.toString());
                                                  }    
                                                  // Navigator.push(
                                                  //   context, MaterialPageRoute(
                                                  //     builder:(
                                                  //       context
                                                  //     ) =>  )
                                                  // );
                                                },
                                              )
                                              // child: ElevatedButton(
                                              //   style:ButtonStyle(
                                              //     backgroundColor: MaterialStateProperty.all<Color>(
                                              //       Colors.yellow[700]
                                              //     ),
                                              //   ),
                                                //child: Align(
                                                  // child: Text(
                                                  //   "JOIN GAME",
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //       fontFamily: 'PumpkinCheesecake',
                                                  //       fontSize: 35,
                                                  //       color: Colors.white
                                                  //   ),
                                                  // ),
                                                //),
                                                //onPressed: (){
                                                  //_teddyController.submitMatchId();
                                                //   if(roomCodeController.text.compareTo(matchId) == 0){
                                                //     setState(() {
                                                //       animationType = "success";                               
                                                //     });
                                                //   }
                                                //   else {
                                                //     setState(() {
                                                //       animationType = "fail";                               
                                                //     });
                                                //   }
                                                //},
                                              //),
                                            ),
                                            Expanded(
                                              child: Container(),
                                            ),
                                          ],
                                        )
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                    ],
                                  )
                                ),
                              ]
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ),
                Expanded(
                    child: Container(
                        
                    ),
                  )
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            )
          )
        ],
      ),

      //)
    );
  }
}