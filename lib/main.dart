import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/screens/wrapper.dart';
import 'package:cinema_food/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService()
          .user, //what kind of stream are we listening to from AuthService, with the metod Stream<User> get user
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
