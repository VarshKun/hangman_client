import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hangman_multiplayer/category.dart';

class _InformationDialog extends State<InformationDialog> {
  final int _category;
  final String dropdownValue2;
  final String roomCode;
  _InformationDialog(this._category, this.dropdownValue2, this.roomCode);

  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              focusColor: Colors.yellow,
              splashRadius: 2,
              icon: Icon(Icons.cancel),
              iconSize: 30,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          BorderedText(
            strokeWidth: 3,
            strokeColor: Colors.grey[900],
            child: Text(
              'INFO',
              style: TextStyle(
                  fontFamily: 'NunitoBold',
                  fontSize: 20,
                  color: Colors.yellow[700],
                  shadows: <Shadow>[
                    Shadow(
                        color: Colors.black,
                        offset: Offset(3, 2),
                        blurRadius: 3)
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
          Lottie.asset('assets/animations/setting.json',
              width: 200, height: 200),
          Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Text(
                    "THEME:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 16,
                        color: Colors.blue),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    "GOAL:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 16,
                        color: Colors.blue),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(
                    "ROOM CODE:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: 13,
                        color: Colors.blue),
                  )),
              Expanded(flex: 1, child: Container()),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  Category.categoryNames.elementAt(_category),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'NunitoBold',
                      fontSize: 15,
                      color: Colors.black54),
                ),
              ),
              Expanded(
                  child: Text(
                "$dropdownValue2",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NunitoBold',
                    fontSize: 15,
                    color: Colors.black54),
              )),
              Expanded(
                  child: Text(
                "$roomCode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NunitoBold',
                    fontSize: 15,
                    color: Colors.black54),
              )),
            ],
          ),
          SizedBox(
            height: 30,
          )
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
  final int _category;
  final String dropdownValue2;
  final String roomCode;
  InformationDialog(this._category, this.dropdownValue2, this.roomCode);

  @override
  _InformationDialog createState() =>
      _InformationDialog(_category, dropdownValue2, roomCode);
}
