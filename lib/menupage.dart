import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'createroom.dart';
import 'joinroom.dart';

// int _avatarIndex = 0;
// String _username;
// String joinGameResponse;
class HomeScreen extends StatefulWidget {
  @override
  _ImageAvatar createState() => _ImageAvatar();
}

class _ImageAvatar extends State<HomeScreen> {
  Set<String> imgPaths = {
    'assets/avatars/default.png',
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
    'assets/avatars/avatar7.png',
    'assets/avatars/avatar8.png',
    'assets/avatars/avatar9.png',
    'assets/avatars/avatar10.png',
    
  };
  var avatarIndex = 0;
  final usernameController = TextEditingController();
  void initState() {
  super.initState();
  usernameController.addListener(() {
    final text = usernameController.text.toLowerCase();
    usernameController.value = usernameController.value.copyWith(
      text: text,
      selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
      composing: TextRange.empty,
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Column(
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
                        flex: 3,
                        child: Container
                        (
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          color: Colors.blue,
                          width: 300,
                          child: ColorizeAnimatedTextKit(
                            repeatForever: true,
                            speed: Duration(microseconds: 300000),
                            pause: Duration(microseconds: 0),
                            text: ["Hangman"],
                            textStyle: TextStyle(
                              fontSize: 57.0,
                              fontFamily: 'ComfortaaBold',
                              fontWeight: FontWeight.bold,
                            ),
                            colors: [
                              Colors.lightBlueAccent[100],
                              Colors.yellow,
                              Colors.yellow[700]
                            ],
                          ),
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
                Expanded(
                  child: Column(
                    children: [
                      Expanded
                      (
                        flex: 3,
                        child: Container(
                          
                        ),
                      ),
                      Expanded
                      (
                        flex: 2,
                        child: IconButton(
                          icon: Icon(Icons.login_rounded),
                          onPressed: (){},
                          color: Colors.white,
                          iconSize: 30
                        ),
                      ),
                      Expanded
                      (
                        flex: 1,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'PumpkinCheesecake',
                            fontSize: 24,
                            color: Colors.white
                          ),
                        ),
                      ),
                      Expanded
                      (
                        flex: 1,
                        child: Container(
                          
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
            child: Container(
              color: Colors.blue,
              child:  Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),                
                      child: Container(
                        color: Colors.white,
                        child: Column
                        (
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: FloatingActionButton(
                                              heroTag: null,
                                              onPressed: () {
                                                setState(() {
                                                  if (avatarIndex == 0) {
                                                    avatarIndex = imgPaths.length - 1;
                                                  } else {
                                                    avatarIndex -= 1;
                                                  }
                                                });
                                              },
                                              child: Icon(Icons.arrow_back_ios_rounded),
                                              backgroundColor: Colors.yellow[700],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      flex: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black87,
                                        radius: 62,
                                        child: CircleAvatar(
                                          radius: 60,
                                          child: Image.asset(imgPaths.elementAt(avatarIndex)),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                             
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: FloatingActionButton(
                                              heroTag: null,
                                              onPressed: () {
                                                setState(() {
                                                  if ((imgPaths.length - 1) == avatarIndex)
                                                    avatarIndex = 0;
                                                  else
                                                    avatarIndex += 1;
                                                });
                                              },
                                              child: Icon(Icons.arrow_forward_ios_rounded),
                                              backgroundColor: Colors.yellow[700],
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
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: TextField(
                                            controller: usernameController,
                                            style: TextStyle(
                                              fontFamily: 'ComfortaaBold'
                                            ),
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Colors.black, width: 1),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              hintText: "Nickname",
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                  ),
                                  Expanded(
                                    child: Container(
                                      
                                    ),
                                  ),
                                ],
                              ), 
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Colors.lightBlueAccent)),
                                            // color: Colors.lightBlueAccent,
                                            // textColor: Colors.white,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => JoinRoom(avatarIndex,usernameController.text)),
                                              );
                                            },
                                            child: Align(
                                              child: Text(
                                                "JOIN ROOM",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'PumpkinCheesecake',
                                                    fontSize: 35),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Colors.yellow[700])),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => CreateRoom(avatarIndex,usernameController.text)),
                                              );
                                            },
                                            child: Align(
                                              child: Text(
                                                "CREATE ROOM",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'PumpkinCheesecake',
                                                    fontSize: 35),
                                              ),
                                            ),
                                          ),

                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      
                                    ),
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
                    child: Container(
                        color: Colors.blue,
                      ),
                  )
                ],
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
    );
  }

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomeScreen(),
    );
  }
}
