import 'package:flutter/material.dart';



class Game extends StatefulWidget {
  @override
  _Game createState() => _Game();
}

class _Game extends State<Game>{
  @override
  Widget build(BuildContext context) {
    //return WillPopScope(
      //onWillPop: () async => false ,
      return Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      );
      
    //);
  }
}