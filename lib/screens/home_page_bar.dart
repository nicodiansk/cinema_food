import 'package:cinema_food/screens/cinema_home_screens/cart_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'cinema_home_screens/film.dart';
import 'cinema_home_screens/menu.dart';
import 'cinema_home_screens/settings.dart';

class HomePageBar extends StatefulWidget {
  @override
  _HomePageBarState createState() => _HomePageBarState();
}

class _HomePageBarState extends State<HomePageBar> {
  int selectedPage = 0;
  final _pageOption = [MenuPage(), FilmPage(), UserSettings(), Cart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.fastfood, title: 'Menù'),
          TabItem(icon: Icons.movie, title: 'Film'),
          TabItem(
            icon: Icons.person,
            title: 'User',
          ),
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
