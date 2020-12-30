import 'package:flutter/material.dart';

class FilmPage extends StatefulWidget {
  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Center(child: Text('FILM PAGE'))],
      ),
    );
  }
}
