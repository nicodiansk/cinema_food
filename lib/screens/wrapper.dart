import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/screens/authenticate/authenticate.dart';
import 'package:cinema_food/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      return Home();
    }
  }
}
