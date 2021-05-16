import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman_multiplayer/chatbox.dart';

String wordToFind;
int wordcounter = 0;
List<String> charsToFind;
List<String> charsToRemaining;   
List<String> charsUsedBad = [];
String hiddenWordToGuess;
int doomsdayClock; 
bool won = false;
bool startNewWord = true;
// ignore: camel_case_types
class starting_game extends StatefulWidget {
  final List<String> words;
  starting_game(this.words);
  static _starting_game currentinstance;
  @override
  State createState() => new _starting_game(words);
}

// ignore: camel_case_types
class _starting_game extends State<starting_game > {
  final List<String> words;
  _starting_game(this.words){
    starting_game.currentinstance = this;
  }
  
  @override
  Widget build(BuildContext context) {
    if (startNewWord){
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
              child: Center(
                child: Text(
                  hiddenWordToGuess,
                  style: TextStyle(
                    letterSpacing: 15,
                    fontSize: 20,
                    //decoration: TextDecoration.underline 
                  ),
                ),
              ),
            ),
            Expanded(child: Text(charsUsedBad.toString())),
            Expanded(
              child: Text(((){
                if (won == true){
                  return "NEXT ROUND LOADING...";
                }
                else{
                  return "No of guesses remaining: " + doomsdayClock.toString();
                }
              })())
              // child: Text("No of guesses remaining: " + doomsdayClock.toString()),
              
            ),
          ],
        ),
      ),
    );
    

  }
  // ignore: missing_return
  Future<Null> submitGuess(){
    if(doomsdayClock > 0){
      String guess = ChatWindow.TextController.text.toLowerCase();
      if(guess.length == 1){
        if(!wordCurrently(charsToFind, wordToFind).contains(guess)){
          print(guess);
          if(!charsUsedBad.contains(guess)){
            print("used:" + charsUsedBad.toString());
            if(checkForChar(guess)){
              charsToFind.remove(guess);
            }
            else{
              doomsdayClock -= 1;
              charsUsedBad.add(guess);
              print("Wrong! Remaining guesses:" + doomsdayClock.toString());
            }
          }
          if(charsToFind.length == 0){
            print(wordCurrently(charsToFind, wordToFind));
            won = true;
            print ("You made it");
            startNewWord = true;
            Future.delayed(const Duration(seconds: 3), () {
              wordcounter ++;
              won = false;
              newGame();
            });
          }
          if (doomsdayClock <= 0){
            print ("You died");
            startNewWord = true;
            Future.delayed(const Duration(seconds: 3), () {
              wordcounter ++;
              newGame();
            });
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
  Future<Null> newGame(){
    charsUsedBad = [];
    charsUsedBad.clear();
    doomsdayClock = 7;
    charsToFind = [];
    for(int i = 0; wordToFind.length>i;i++){
      if(!charsToFind.contains(wordToFind.split("")[i].toLowerCase()) && wordToFind.split("")[i] != " "){
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