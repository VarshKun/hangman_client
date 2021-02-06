import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class CustomProgressBar extends StatelessWidget{
  final double width;
  final double value;
  final double totalValue;
  CustomProgressBar(this.width,this.value,this.totalValue);

  @override
  Widget build(BuildContext context) {
    double ratio = value/totalValue;
    return Row(
      children: [
        Stack(
          children:<Widget> [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(8)
              ),
            ),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                width: width*ratio,
                height: 10,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (ratio < 0.3)? Colors.red :(ratio < 0.6) ? Colors.yellow[700] :Colors.yellow[800],
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            )
          ],
          
        ),
      ],
    );  
  }
}

class TimeState with ChangeNotifier{
  int _time = 15;
  int get time => _time;
  set time (int newTime){
    _time = newTime; notifyListeners();
  }
}