import 'package:cinema_food/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cinema_food/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
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
