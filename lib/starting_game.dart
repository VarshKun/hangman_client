import 'dart:convert';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/chatbox.dart';
import 'hangman_client.dart';
import 'package:im_animations/im_animations.dart';

String wordToFind;
int wordcounter = 0;
int roundcounter = 1;
List<String> charsToFind;
List<String> charsToRemaining;
List<String> charsUsedBad = [];
String hiddenWordToGuess;
int doomsdayClock;
bool wonRound = false;
bool wonMatch = false;
bool startNewWord = true;
int totalScore = 0;

// ignore: camel_case_types
class starting_game extends StatefulWidget {
  final List<String> words;
  final String pointsToWin;
  final String matchId;
  final String playerId;
  final int avatarIndex;
  final String username;
  final int matchStatus;

  starting_game(this.words, this.pointsToWin, this.matchId, this.playerId,
      this.avatarIndex, this.username, this.matchStatus);
  static _starting_game currentinstance;
  @override
  State createState() => new _starting_game(words, pointsToWin, matchId,
      playerId, avatarIndex, username, matchStatus);
}

// ignore: camel_case_types
class _starting_game extends State<starting_game> {
  final List<String> words;
  String pointsToWin;
  String matchId;
  String playerId;
  Artboard _riveArtboard;
  StateMachineController _controller;
  SMINumber lives;
  int avatarIndex;
  String username;
  int matchStatus;
  bool get isPlaying => _controller.isActive ?? false;
  _starting_game(this.words, this.pointsToWin, this.matchId, this.playerId,
      this.avatarIndex, this.username, this.matchStatus) {
    starting_game.currentinstance = this;
    totalScore = 0;
    wonRound = false;
    wonMatch = false;
    charsToFind = [];
    startNewWord = false;
    wordcounter = 0;
    roundcounter = 1;
    wordToFind = words[wordcounter];
    charsUsedBad = [];
    charsUsedBad.clear();
    doomsdayClock = 7;
    charsToFind = [];
    for (int i = 0; wordToFind.length > i; i++) {
      if (!charsToFind.contains(wordToFind.split("")[i].toLowerCase()) &&
          wordToFind.split("")[i] != " ") {
        charsToFind.add(wordToFind.split("")[i].toLowerCase());
      }
    }
    hiddenWordToGuess = wordCurrently(charsToFind, wordToFind);
  }

  void errorHandler(Object error, StackTrace trace) {
    print(error);
  }

  void updateScoreHandler(data) {
    //String _data = new String.fromCharCodes(data).trim();
    try {
      final parsed = json.decode(data);
      if (parsed['error'] != null) {
        print(parsed['error']);
      }
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }
  }

  // ignore: missing_return
  Future<String> showOverlay() async {
    setState(() {
      wonRound = true;
    });
  }

  @override
  void initState() {
    super.initState();
    rootBundle
        .load('assets/animations/hangman_pencilmation.riv')
        .then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller =
          StateMachineController.fromArtboard(artboard, 'StateMachine1');
      if (controller != null) {
        artboard.addController(controller);
        lives = controller.inputs.elementAt(0);
      }
      setState(() => _riveArtboard = artboard);
    });
  }

  void reinitialiseWidget() async {
    Future.delayed(Duration(milliseconds: 500), () {
      rootBundle
          .load('assets/animations/hangman_pencilmation.riv')
          .then((data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'StateMachine1');
        if (controller != null) {
          artboard.addController(controller);
          lives = controller.inputs.elementAt(0);
        }
        setState(() => _riveArtboard = artboard);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startNewWord) {
      startNewWord = false;
      wordToFind = words[wordcounter];
      newGame();
      reinitialiseWidget();
    }

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Round " + roundcounter.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 6,
                            fontSize: 20,
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.black38,
                          child: Center(
                            child: Text(
                              hiddenWordToGuess,
                              style: TextStyle(
                                letterSpacing: 10,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                      //color: Colors.white,
                      child: Text("Letters used: " + charsUsedBad.toString()),
                    ))
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 6,
                child: Container(
                  //color: Colors.black,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            //color: Colors.amber,
                            ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          //color: Colors.cyanAccent,
                          child: Center(
                            child: _riveArtboard == null
                                ? const SizedBox()
                                : Rive(
                                    alignment: Alignment.bottomCenter,
                                    artboard: _riveArtboard,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          //color: Colors.amber,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                //color: Colors.black,
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            //color: Colors.cyan,
                                            )),
                                    Expanded(
                                        flex: 4,
                                        child: Stack(
                                          children: [
                                            Container(
                                              //color: Colors.black,
                                              child: Center(
                                                child: HeartBeat(
                                                  beatsPerMinute: 70,
                                                  child: Image.asset(
                                                    'assets/images/heart.png',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.blueAccent,
                                              child: Center(
                                                child: BorderedText(
                                                  strokeWidth: 2,
                                                  strokeColor:
                                                      Colors.yellow[700],
                                                  child: Text(
                                                    doomsdayClock.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            //color: Colors.yellow,
                                            )),
                                  ],
                                ),
                              )),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      //color: Colors.cyan,
                                      )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<void> submitGuess() async {
    if (doomsdayClock > 0) {
      String strGuessTyped = ChatWindow.TextController.text.toLowerCase();
      if (strGuessTyped.length == 1) {
        if (!wordCurrently(charsToFind, wordToFind).contains(strGuessTyped)) {
          print(strGuessTyped);
          if (!charsUsedBad.contains(strGuessTyped)) {
            print("used:" + charsUsedBad.toString());
            if (checkForChar(strGuessTyped)) {
              charsToFind.remove(strGuessTyped);
              totalScore = totalScore + 2;
              print(totalScore);
              try {
                var data = await tcpSendV2(
                    errorHandler, "updatescore/$matchId/$playerId/$totalScore");
                updateScoreHandler(data);
              } on FormatException catch (e) {
                print("That string didn't look like Json." + e.message);
              } on NoSuchMethodError catch (e) {
                print('That string was null!' + e.stackTrace.toString());
              }
            } else {
              doomsdayClock -= 1;
              charsUsedBad.add(strGuessTyped);
              print("Wrong! Remaining guesses:" + doomsdayClock.toString());
              lives.value++;
            }
          }
          if (charsToFind.length == 0) {
            print(wordCurrently(charsToFind, wordToFind));
            wonRound = true;
            print("You guessed the word correctly.");
            totalScore = totalScore + 5;
            print(totalScore);
            try {
              var data = await tcpSendV2(
                  errorHandler, "updatescore/$matchId/$playerId/$totalScore");
              updateScoreHandler(data);
            } on FormatException catch (e) {
              print("That string didn't look like Json." + e.message);
            } on NoSuchMethodError catch (e) {
              print('That string was null!' + e.stackTrace.toString());
            }

            if (totalScore < int.parse(pointsToWin)) {
              startNewWord = true;
              //Future.delayed(const Duration(seconds: 3), () {
              wordcounter++;
              roundcounter++;
              wonRound = false;
              newGame();
              //});
            }
            // } else {
            //   print("You are the winner!");
            //   showOverlay().then((value) => {
            //         showDialog(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return winDialog(avatarIndex, username);
            //             })
            //       });
            // }
          }
          if (doomsdayClock <= 0) {
            print("You died.");
            startNewWord = true;
            //Future.delayed(const Duration(seconds: 3), () {
            wordcounter++;
            roundcounter++;
            //won = true;
            //newGame();
            //});
          }
          print(wordCurrently(charsToFind, wordToFind));
          setWordShow();
        }
      }
    }
  }

  bool checkForChar(String charToCheck) {
    return (charsToFind.contains(charToCheck));
  }

  String wordCurrently(charsToRemaining, wordToHide) {
    String out = "";
    for (int i = 0; wordToHide.length > i; i++) {
      if (charsToRemaining.contains(wordToHide.split("")[i].toLowerCase())) {
        out += "_ ";
      } else {
        out += wordToHide.split("")[i] + " ";
      }
    }
    return out;
  }

  // ignore: missing_return
  Future<Null> newGame() {
    charsUsedBad = [];
    charsUsedBad.clear();
    doomsdayClock = 7;

    charsToFind = [];
    for (int i = 0; wordToFind.length > i; i++) {
      if (!charsToFind.contains(wordToFind.split("")[i].toLowerCase()) &&
          wordToFind.split("")[i] != " ") {
        charsToFind.add(wordToFind.split("")[i].toLowerCase());
      }
    }
    print(charsToFind);
    setWordShow();
  }

  // ignore: missing_return
  Future<Null> setWordShow() {
    setState(() {
      hiddenWordToGuess = wordCurrently(charsToFind, wordToFind);
    });
  }
}
