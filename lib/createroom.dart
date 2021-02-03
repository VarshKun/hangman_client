import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:hangman_multiplayer/category.dart';
import 'package:bordered_text/bordered_text.dart';


class CreateRoom extends StatefulWidget {
  @override
  _CreateRoom createState() => _CreateRoom();
}

class _CreateRoom extends State<CreateRoom> {
  String dropdownValue1 = '2';
  String dropdownValue2 = '70';
  bool _value01 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Column(
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
                              flex: 2,
                              child: Row
                              (
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                     
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: BorderedText(
                                      strokeWidth: 3,
                                      strokeColor: Colors.grey[900],
                                      child: Text(
                                        'SETUP',
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
                                              child: Container(
                                                
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                     
                                                    )
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      'PLAYERS',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontFamily: 'NunitoBold'
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                     
                                                    )
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
                                                    child: Container(
                                                      
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child: DropdownButton<String>(
                                                        isExpanded: true,
                                                        value: dropdownValue1,
                                                        iconSize: 24,
                                                        elevation: 1,
                                                        style: TextStyle(color: Colors.black, fontSize: 18),
                                                        underline: Container(
                                                          height: 1,
                                                          color: Colors.grey,
                                                        ),
                                                        onChanged: (String newValue) {
                                                          setState(() {
                                                            dropdownValue1 = newValue;
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
                                                        ].map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
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
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Text(
                                                      'POINTS',
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontFamily: 'NunitoBold'
                                                      ),
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
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child: DropdownButton<String>(
                                                        isExpanded: true,
                                                        value: dropdownValue2,
                                                        iconSize: 24,
                                                        elevation: 1,
                                                        style: TextStyle(color: Colors.black, fontSize: 18),
                                                        underline: Container(
                                                          height: 1,
                                                          color: Colors.grey,
                                                        ),
                                                        onChanged: (String newValue) {
                                                          setState(() {
                                                            dropdownValue2 = newValue;
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
                                                        ].map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
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
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      
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
                                                          flex: 23,
                                                           child: Text(
                                                            'VISIBLE ROOM',
                                                            style: TextStyle(
                                                              color: Colors.blueGrey,
                                                              fontFamily: 'NunitoBold'
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
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 8,
                                                          child: Container(
                                                            
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex:16,
                                                          child: AdvancedSwitch(
                                                            activeColor: Colors.blue,
                                                            activeChild: Text('ON'),
                                                            inactiveChild: Text('OFF'),
                                                            borderRadius: BorderRadius.circular(5),
                                                            width: 55,
                                                            value: _value01,
                                                            onChanged: (value) => setState(() {
                                                              _value01 = value;
                                                            }),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 8,
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
                  child: Container(
                    
                  ),
                ),
                Expanded(
                  flex: 35,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                         
                        )
                      ),
                      Expanded(
                        flex: 22,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Color.fromRGBO(10,94,251,0.4),
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
                                              child: Container(
                                                
                                              ),
                                            ),
                                            Expanded(
                                              flex: 15,
                                              child: Text(
                                                'CHOOSE A THEME ',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'NunitoExtraLight',
                                                  color: Color.fromRGBO(255,255,255,1),
                                                  //color: Color.fromRGBO(186,200,232,2),
                                                  fontWeight: FontWeight.w500 
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                
                                              ),
                                            ),
                                          ],
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
                                  flex: 5,
                                  child: Category()
                                ),
                                Expanded(
                                  flex: 2,
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
                                              child:FloatingActionButton.extended(
                                                backgroundColor: Colors.yellow[700],
                                                focusColor: Colors.yellow[800],
                                                splashColor: Colors.yellow[800],
                                                elevation: 10,
                                                onPressed: (){}, 
                                                label: Text('NEW ROOM'),
                                                icon: Icon(Icons.settings_outlined),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          
                        )
                      ),
                    ],
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
    );
  }
}