import 'package:cinema_food/modules/user.dart';
import 'package:cinema_food/services/database.dart';
import 'package:cinema_food/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(userData.uid),
                        Text(userData.name),
                        Text('${userData.points}'),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
