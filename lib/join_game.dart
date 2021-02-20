import 'package:flutter/material.dart';

class JoinGameButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  final Function onPressed;

  const JoinGameButton({
    Key key,
    @required this.child,
    this.gradient,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(255, 191, 0, 1.0),
              Color.fromRGBO(102, 207, 255, 0.8),
              Color.fromRGBO(19, 186, 254, 0.4)
            ],
          )),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}