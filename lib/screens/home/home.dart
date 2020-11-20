import 'package:cinema_food/modules/settings.dart';
import 'package:cinema_food/screens/cinema/film.dart';
import 'package:cinema_food/screens/cinema/menu.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cinema_food/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Cinema Food - Home'),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                'settings',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
