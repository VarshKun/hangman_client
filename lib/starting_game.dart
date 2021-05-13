import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class starting_game extends StatefulWidget {
  final dynamic wordList;
  starting_game(this.wordList);
  

  @override
  State createState() => new _starting_game(wordList);
}


// ignore: camel_case_types
class _starting_game extends State<starting_game > {
  final dynamic _wordList;
  _starting_game(this._wordList);

  @override
  Widget build(BuildContext context) {
    print ('wordlist: $_wordList');
    return Container(
      color: Colors.white,
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Expanded(
    //             flex: 2,
    //             child: Column(
    //               children: [
    //                 Expanded(
    //                   flex:2,
    //                   child:Container(
                        
    //                   )
    //                 ),
    //                 Expanded(
    //                   child: BorderedText(
    //                     strokeWidth: 3,
    //                     strokeColor: Colors.grey[900],
    //                     child: Text(
    //                       'STARTING',
    //                       style: TextStyle(
    //                         fontFamily: 'NunitoBold',
    //                         fontSize: 20,
    //                         color: Colors.yellow[700],
    //                         shadows: <Shadow>[
    //                           Shadow(
    //                             color: Colors.black,
    //                             offset: Offset(3,2),
    //                             blurRadius: 3
    //                           )
    //                         ]
    //                       ),
    //                       textAlign: TextAlign.center,
    //                     ),
    //                   ),                              
    //                 ),
    //               ],
    //             )
    //           ),
    //           Expanded(
    //             flex: 3,
    //             child: Lottie.asset(
    //               'assets/animations/waiting_pigeon.json',
    //               width: 400,
    //               height: 200
    //             ),
    //           ),
    //           Expanded(
    //             child: Column(
    //               children: [
    //                 Expanded(
    //                   child:Text(
    //                     'STARTING GAME',
    //                     style: TextStyle(
    //                       fontFamily: 'NunitoBold',
    //                       fontSize:14,
    //                       color: Colors.blueGrey[600]
    //                     ),
    //                   )
    //                 ),
    //                 Expanded(
    //                   flex:2,
    //                   child:Container(
                        
    //                   )
    //                 ),
    //               ],
    //             )
    //           ),
    //         ],
    //       ),
    //     ),
    );
      
  }
}