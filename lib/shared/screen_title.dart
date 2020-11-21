import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  ScreenTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1000),
      builder: (
        BuildContext context,
        double _val,
        Widget child,
      ) {
        return Opacity(
          opacity: _val,
          child: Padding(
            padding: EdgeInsets.only(top: _val * 20),
            child: child,
          ),
        );
      },
      child: RichText(
          text: TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 70,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
            TextSpan(
                text: '.',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 80,
                    fontWeight: FontWeight.bold))
          ])),
    );
  }
}
