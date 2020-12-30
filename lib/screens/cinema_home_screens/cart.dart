import 'package:cinema_food/shared/page_title.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: PageTitle(
              title: 'Il tuo carrello',
            ),
          )
        ],
      ),
    );
  }
}
