import 'package:cinema_food/modules/cart_list.dart';
import 'package:cinema_food/modules/food.dart';
import 'package:cinema_food/shared/page_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinema_food/services/database.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Food> cart;
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
          ),
        ],
      ),
    );
  }
}
