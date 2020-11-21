import 'package:cinema_food/screens/cinema/settings.dart';
import 'package:cinema_food/screens/cinema/cart.dart';
import 'package:cinema_food/screens/cinema/film.dart';
import 'package:cinema_food/screens/cinema/menu.dart';
import 'package:cinema_food/screens/home/home.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePageBar extends StatefulWidget {
  @override
  _HomePageBarState createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  final AuthService _auth = AuthService();
  int selectedPage = 0;
  final _pageOption = [Home(), MenuPage(), FilmPage(), UserSettings(), Cart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedPage != 5 ? _pageOption[selectedPage] : null,
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fastfood, title: 'Menù'),
          TabItem(icon: Icons.movie, title: 'Film'),
          TabItem(icon: Icons.person, title: 'User'),
          TabItem(icon: Icons.shopping_cart, title: 'Carrello'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
        activeColor: Colors.lightBlueAccent,
        backgroundColor: Colors.purple[300],
        color: Colors.white,
      ),
      backgroundColor: Colors.white,
    );
  }
}
