import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class waitingStatus extends StatefulWidget {
  
  @override
  State createState() => new _waitingStatus();
}


// ignore: camel_case_types
class _waitingStatus extends State<waitingStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}