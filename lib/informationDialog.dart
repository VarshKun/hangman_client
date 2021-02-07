import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class _InformationDialog extends State<InformationDialog>{
  
  dialogContent(BuildContext context){
    return Container(
      
      decoration:new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:<Widget> [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              focusColor: Colors.yellow,
              splashRadius: 2,
              icon: Icon(Icons.cancel),
              iconSize: 30,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          Text(
            'Exit game?',
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'NunitoBold'
            ),
          ),
          
          Lottie.asset(
            'assets/animations/log_out.json',
            width: 150,
            height: 150
          ),
          SizedBox(height: 10.0),
          Text(
            "Are you sure you want to exit the game?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'NunitoBold',
            ),
          ),
          SizedBox(height: 16.0),
          
              
       
           
          SizedBox(height: 24),
        ],
      ),
    );
  }
  // @override
  // _CustomDialog createState() => _CustomDialog();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
class InformationDialog extends StatefulWidget {

  @override
  _InformationDialog createState() => _InformationDialog();
}
