import 'package:cinema_food/screens/cinema/settings.dart';
import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/screens/authenticate/authenticate.dart';
import 'package:cinema_food/screens/cinema/cart.dart';
import 'package:cinema_food/screens/cinema/film.dart';
import 'package:cinema_food/screens/cinema/menu.dart';
import 'package:cinema_food/screens/home/home.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return home or authenticate widget
    //every time a user sign in/out a value is passed into the stream of User from main.dart to wrapper.dart wqith the provider
    final user = Provider.of<User>(
        context); //what type of data we receive every time there is a new value
    print('Stato attuale utenti: $user');
    if (user == null) {
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          TabItem(icon: Icons.logout, title: 'Logout'),
        ],
        initialActiveIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
            if (selectedPage == 5) {
              Alert(
                context: context,
                type: AlertType.warning,
                title: "LOGOUT",
                desc:
                    "Stai per disconnetterti dalla sessione attuale. Continuare?",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Indietro",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.purple,
                  ),
                  DialogButton(
                    child: Text(
                      "Disconnettimi",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      _auth.signOut();
                      Navigator.pop(context);
                    },
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.lightBlueAccent,
                    ]),
                  )
                ],
              ).show();
              //_auth.signOut();
            }
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
