import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hangman_multiplayer/avatarIndex.dart';
import 'package:hangman_multiplayer/starting_game.dart';

//const String defaultUserName = "VarshKun";


class Chat extends StatefulWidget {
  final int avatarIndex;
  final String username;
  Chat(this.avatarIndex, this.username);

  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  // ignore: non_constant_identifier_names
  static final TextEditingController TextController = new TextEditingController();
  bool _isWriting = false;
  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(10, 94, 251, 0.1),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
              reverse: true,
              padding: new EdgeInsets.all(6.0),
            )),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(color: Colors.white),//Color.fromRGBO(10, 94, 251, 0.8)),
        ),
      ]),
    );
  }


  Widget _buildComposer() {

    return new IconTheme(
        data: new IconThemeData(color: Color.fromRGBO(10, 94, 251, 0.8)),//Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                  child: new TextField(
                    controller: TextController,
                    onChanged:(String txt) => {
                      ChatWindow.TextController.text = txt,
                      setState(() {                        
                        _isWriting = txt.length > 0;
                      })                      
                    },
                    onSubmitted: (String txt) => {
                      _submitMsg(TextController.text,widget.avatarIndex,widget.username),
                      _isWriting = false,
                      ChatWindow.TextController.text = txt,
                      starting_game.currentinstance.submitGuess()
                    },
                    decoration:
                      new InputDecoration.collapsed(hintText: "Enter letter here"),
                  ),
              ),
              new Container(
                //starting_game.currentinstance.submitGuess(),
                margin: new EdgeInsets.symmetric(horizontal: 3.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                  ? new CupertinoButton(
                    child: new Text("Submit"),
                    onPressed: _isWriting ? () =>{
                      _submitMsg(TextController.text,widget.avatarIndex,widget.username),
                      
                    } 
                        : null
                )
                    : new IconButton(
                    icon: new Icon(Icons.message),
                    onPressed: _isWriting ? () =>{
                      starting_game.currentinstance.submitGuess(),
                      _submitMsg(TextController.text,widget.avatarIndex,widget.username)
                    } 
                        : null
                )
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? new BoxDecoration(
            border:
              new Border(top: new BorderSide(color: Colors.brown))) :
              null
        ),
    );
  }

  _submitMsg(String txt, int avatarIndex, String username) {
    if(txt != null && txt != ""){
      TextController.clear();
      setState(() {
        _isWriting = false;
      });
      Msg msg = new Msg(
        avatarIndex: avatarIndex,
        username: username,
        txt: txt,
        animationController: new AnimationController(
            vsync: this,
          duration: new Duration(milliseconds: 300)
        ),
      );
      setState(() {
        _messages.insert(0, msg);
      });
      msg.animationController.forward();
    }
    // if (starting_game.currentinstance != null)
    //   starting_game.currentinstance.submitGuess();
  }
  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

// ignore: must_be_immutable
class Msg extends StatelessWidget {

  Msg({this.txt, this.animationController, this.avatarIndex, this.username});
  final String txt;
  final AnimationController animationController;
  final int avatarIndex;
  final String username;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(child: Image.asset(AvatarIndices.imgPaths.elementAt(avatarIndex)),
                // style: TextStyle(
                //   fontFamily: 'NunitoExtraLight'

                // ),
              )),

            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(username, style: TextStyle(color: Colors.white,fontFamily: 'NunitoBold',fontSize: 15)),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(txt,style:TextStyle(color: Colors.white,fontFamily: 'NunitoExtraLight',fontWeight: FontWeight.bold,fontSize: 14)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}