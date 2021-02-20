import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';


// var txt = TextEditingController(text: matchId,);
bool _hasBeenPressed = false;
String matchId = "";

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
class _CustomDialog extends State<CustomDialog>{
  
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
            'Invite friends',
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'NunitoBold'
            ),
          ),
          
          Lottie.asset(
            'assets/animations/paper_plane.json',
            width: 150,
            height: 150
          ),
          SizedBox(height: 10.0),
          Text(
            "Invite your friends to the room! Send the code below:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'NunitoBold',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            style: TextStyle(
              fontFamily: 'NunitoExtraLight',
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            controller: TextEditingController(text: matchId),
            focusNode: AlwaysDisabledFocusNode(),
          ),
          SizedBox(height: 24.0),
          Row(
            children: 
              [
                Expanded(child:Container()),
                Expanded(
                  flex: 2,
                  child: FloatingActionButton.extended(
                    backgroundColor: _hasBeenPressed ? Colors.blue : Colors.yellow[700],
                    focusColor: Colors.yellow[800],
                    splashColor: Colors.yellow[800],
                    elevation: 10,
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: matchId));
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;                       
                      });
                      
                    },
                    label: _hasBeenPressed ? Text(
                      'COPIED',
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                      ),
                    ) : Text(
                      'COPY',
                      style: TextStyle(
                        fontFamily: 'NunitoBold',
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                      ),
                    ),
                    icon: Icon(Icons.copy),
                  ),
                ),
                Expanded(child:Container()),
              ],
          ),
          SizedBox(height: 20,)
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
class CustomDialog extends StatefulWidget {

  @override
  _CustomDialog createState() => _CustomDialog();

  CustomDialog(String _matchId){
    try {
      final parsed = json.decode(_matchId); 
      matchId = parsed['matchId'];
    } on FormatException catch (e) {
      print("That string didn't look like Json." + e.message);
    } on NoSuchMethodError catch (e) {
      print('That string was null!' + e.stackTrace.toString());
    }    
  }  

  
}

// class _CustomDialog extends State<CustomDialog>{
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
