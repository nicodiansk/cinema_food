import 'package:cinema_food/screens/cinema/settings.dart';
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
    );
  }
}
