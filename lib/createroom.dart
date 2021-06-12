import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:hangman_multiplayer/category.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hangman_multiplayer/inviteDialog.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'game.dart';
import 'hangman_client.dart';

int _category = 0;
int _avatarIndex = 0;
String _username;

class CreateRoom extends StatefulWidget {
  CreateRoom(int avatarIndex, String username) {
    _avatarIndex = avatarIndex;
    _username = username;
  }

  @override
  _CreateRoom createState() => _CreateRoom();
}

class _CreateRoom extends State<CreateRoom> {
  String dropdownValue1 = '2';
  String pointsToWin = '70';
  bool _value01 = false;
  bool _isLoading = false;
  String dataRecv = "";

  Future<String> showOverlay() async {
    setState(() {
      _isLoading = true;
    });

    dataRecv = await tcpSendV2(
        errorHandler, "newmatch/$_category/$dropdownValue1/$pointsToWin");
    return dataRecv;
  }

  void errorHandler(Object error, StackTrace trace) {
    setState(() {
      _isLoading = false;
    });
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: WillPopScope(
        onWillPop: () async => false,
        child: LoadingOverlay(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: IconButton(
                                                          icon: Icon(Icons
                                                              .arrow_back_rounded),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            //Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen() ));
                                                          },
                                                          color: Colors
                                                              .yellow[700],
                                                          iconSize: 35),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Center(
                                                        child: Text(
                                                          'BACK',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'PumpkinCheesecake',
                                                              fontSize: 30,
                                                              color: Colors
                                                                  .yellow[700]),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: BorderedText(
                                          strokeWidth: 3,
                                          strokeColor: Colors.grey[900],
                                          child: Text(
                                            'SETUP',
                                            style: TextStyle(
                                                fontFamily: 'NunitoBold',
                                                fontSize: 40,
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
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
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
                            flex: 1,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 22,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container()),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'PLAYERS',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey,
                                                              fontFamily:
                                                                  'NunitoBold'),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container()),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: ButtonTheme(
                                                          alignedDropdown: true,
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            value:
                                                                dropdownValue1,
                                                            iconSize: 24,
                                                            elevation: 1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18),
                                                            underline:
                                                                Container(
                                                              height: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                dropdownValue1 =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              '2',
                                                              '3',
                                                              '4',
                                                              '5',
                                                              '6',
                                                              '7',
                                                              '8',
                                                              '9',
                                                              '10'
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                          'POINTS',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey,
                                                              fontFamily:
                                                                  'NunitoBold'),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 5,
                                                        child: ButtonTheme(
                                                          alignedDropdown: true,
                                                          child: DropdownButton<
                                                              String>(
                                                            isExpanded: true,
                                                            value: pointsToWin,
                                                            iconSize: 24,
                                                            elevation: 1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18),
                                                            underline:
                                                                Container(
                                                              height: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            onChanged: (String
                                                                newValue) {
                                                              setState(() {
                                                                pointsToWin =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: <String>[
                                                              '70',
                                                              '100',
                                                              '120',
                                                              '150',
                                                              '240',
                                                              '360',
                                                              '480'
                                                            ].map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(),
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
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'VISIBLE ROOM',
                                                    style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontFamily:
                                                            'NunitoBold'),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: AdvancedSwitch(
                                                    activeColor: Colors.blue,
                                                    activeChild: Text('ON'),
                                                    inactiveChild: Text('OFF'),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    width: 58,
                                                    value: _value01,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      _value01 = value;
                                                    }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
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
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 35,
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            flex: 22,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Color.fromRGBO(10, 94, 251, 0.4),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 15,
                                                  child: Text(
                                                    'CHOOSE A THEME ',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'NunitoExtraLight',
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        //color: Color.fromRGBO(186,200,232,2),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 5,
                                        child: Category(
                                          onSelectedIndexChanged:
                                              (newCategory) {
                                            _category = newCategory;
                                          },
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  //child:WillPopScope(
                                                  //onWillPop: ()  async => false,
                                                  child: FloatingActionButton
                                                      .extended(
                                                    backgroundColor:
                                                        Colors.yellow[700],
                                                    focusColor:
                                                        Colors.yellow[800],
                                                    splashColor:
                                                        Colors.yellow[800],
                                                    elevation: 10,
                                                    onPressed: () {
                                                      String _playerId;
                                                      //String matchStatusResponse;
                                                      showOverlay().then(
                                                          (createGameResponse) =>
                                                              {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => Game(
                                                                          _category,
                                                                          pointsToWin,
                                                                          createGameResponse,
                                                                          _avatarIndex,
                                                                          _username,
                                                                          _playerId,
                                                                          null)),
                                                                ),
                                                                showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return CustomDialog(
                                                                              createGameResponse);
                                                                        })
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              setState(() {
                                                                                _isLoading = false;
                                                                              })
                                                                            }),
                                                              });
                                                    },
                                                    label: Text(
                                                      'NEW ROOM',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'NunitoBold',
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    icon: Icon(
                                                      Icons.settings_outlined,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                  //),
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
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: SpinKitPouringHourglass(
            color: Colors.yellow[800],
            size: 60,
          ),
        ),
      ),
    );
  }
}
