import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/chatbox.dart';
import 'hangman_client.dart';

String wordToFind;
int wordcounter = 0;
List<String> charsToFind;
List<String> charsToRemaining;
List<String> charsUsedBad = [];
String hiddenWordToGuess;
int doomsdayClock;
bool won = false;
bool startNewWord = true;
int totalScore = 0;

// ignore: camel_case_types
class starting_game extends StatefulWidget {
  final List<String> words;
  final String pointsToWin;
  final String matchId;
  final String playerId;
  starting_game(this.words, this.pointsToWin, this.matchId, this.playerId);
  static _starting_game currentinstance;
  @override
  State createState() =>
      new _starting_game(words, pointsToWin, matchId, playerId);
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
  bool get isPlaying => _controller.isActive ?? false;
  _starting_game(this.words, this.pointsToWin, this.matchId, this.playerId) {
    starting_game.currentinstance = this;
    totalScore = 0;
    won = false;
    charsToFind = [];
    startNewWord = false;
    wordcounter = 0;
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
    String _data = new String.fromCharCodes(data).trim();
    try {
      final parsed = json.decode(_data);
      if (parsed['error'] != null) {
        print(parsed['error']);
      }
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }
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
        // lives = controller.findInput('DoomsDayClock');
        lives = controller.inputs.elementAt(0);
      }
      setState(() => _riveArtboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (startNewWord) {
      startNewWord = false;
      wordToFind = words[wordcounter];
      newGame();
    }

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            //Expanded(child: Container(color: Colors.cyan,)),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 10,
                      child: Container(
                        color: Colors.yellow,
                      )),
                  Text(
                    "Round 1",
                    style: TextStyle(
                      letterSpacing: 10,
                      fontSize: 20,
                      //decoration: TextDecoration.underline
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.black,
                      )),
                  Expanded(
                    flex: 18,
                    child: Container(
                      color: Colors.cyan,
                      child: Center(
                        child: Text(
                          hiddenWordToGuess,
                          style: TextStyle(
                            letterSpacing: 10,
                            fontSize: 20,
                            //decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Expanded(child: Text(charsUsedBad.toString())),
            // Expanded(child: Text((() {
            //   if (won == true) {
            //     won = false;
            //     return "NEXT ROUND LOADING...";
            //   } else {
            //     return "No of guesses remaining: " + doomsdayClock.toString();
            //   }
            // })())),
            // SizedBox(
            //   height: 30,
            // ),
            // Text("Letters used: " + charsUsedBad.toString()),
            // Text((() {
            //   if (won == true) {
            //     won = false;
            //     return "NEXT ROUND LOADING...";
            //   } else {
            //     return "Number of guesses remaining: " +
            //         doomsdayClock.toString();
            //   }
            // })()),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: _riveArtboard == null
                            ? const SizedBox()
                            : Rive(
                                alignment: Alignment.topCenter,
                                artboard: _riveArtboard,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),

                    // Expanded(
                    //     flex: 2,
                    //     child: Container(
                    //       color: Colors.yellow,
                    //     ))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // ignore: missing_return
  Future<Null> submitGuess() {
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
                tcpSend(updateScoreHandler, errorHandler,
                    "updatescore/$matchId/$playerId/$totalScore");
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
            won = true;
            print("You guessed the word correctly.");
            totalScore = totalScore + 5;
            print(totalScore);
            if (totalScore != int.parse(pointsToWin)) {
              startNewWord = true;
              //Future.delayed(const Duration(seconds: 3), () {
              wordcounter++;
              won = false;
              newGame();
              //});
            } else {
              print("You are the winner!");
            }
          }
          if (doomsdayClock <= 0) {
            print("You died.");
            startNewWord = true;
            //Future.delayed(const Duration(seconds: 3), () {
            wordcounter++;
            won = true;
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
