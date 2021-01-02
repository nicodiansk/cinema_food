import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter

import 'package:http/http.dart' as http;
import 'package:cinema_food/shared/avatar.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

Future<List<CartCard>> fetchCartList() async {
  List<CartCard> foodList;
  String token;
  //HttpHeaders.authorizationHeader: token
  //"Authorization": 'Bearer $token'
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  var idToken = await user.getIdToken();
  token = idToken.token;
  print(token);
  final response = await http.get('http://18.219.187.195/api/cart/getcart',
      headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    print('response ' + response.body.toString());
    // If the server did return a 200 OK response,
    // then parse the JSON.
    foodList = (json.decode(response.body) as List)
        .map((i) => CartCard.fromJson(i))
        .toList();

    return foodList;
    //Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load album');
  }
}

// ignore: must_be_immutable
class CartCard extends StatelessWidget {
  final int productId;
  final String title;
  final String category;
  final String size;
  final String ingredients;
  final String image;
  final double price;
  final double calories;
  final String description;
  int quantity = 0;

  CartCard({
    Key key,
    this.productId,
    this.title,
    this.category,
    this.size,
    this.ingredients,
    this.image,
    this.price,
    this.calories,
    this.description,
  }) : super(key: key);

  factory CartCard.fromJson(Map<String, dynamic> json) {
    return CartCard(
      productId: json['id'],
      title: json['title'],
      category: json['cat'],
      size: json['size'],
      ingredients: json['ingredients'],
      image: json['image'],
      price: json['price'],
      calories: json['calories'],
      description: json['description'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10)
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\€ $price",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            CircleAvatar(
              minRadius: 40,
              backgroundImage: NetworkImage(image),
            )
          ],
        ),
      ),
    );
  }
}
