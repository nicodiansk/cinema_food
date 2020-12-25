import 'dart:convert';
import 'dart:ffi';

import 'package:cinema_food/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

Future<List<FoodCard>> fetchFoodList() async {
  List<FoodCard> foodList;
  print('PRIMA DI AWAIT');
  final response = await get('http://18.219.187.195/api/food/getall');
  print('OTTENUTO');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    foodList = (json.decode(response.body) as List)
        .map((i) => FoodCard.fromJson(i))
        .toList();
    return foodList;
    //Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class FoodCard extends StatelessWidget {
  final int productId;
  final String title;
  final String category;
  final String size;
  final String ingredients;
  final String image;
  final double price;
  final double calories;
  final String description;
  final Function press;

  const FoodCard(
      {Key key,
      this.productId,
      this.title,
      this.category,
      this.size,
      this.ingredients,
      this.image,
      this.price,
      this.calories,
      this.description,
      this.press})
      : super(key: key);

  factory FoodCard.fromJson(Map<String, dynamic> json) {
    return FoodCard(
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
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 400,
        width: 270,
        child: Stack(
          children: <Widget>[
            //big container
            Positioned(
              right: 0,
              bottom: 40,
              child: Container(
                height: 380,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    color: kLightSecondaryColor.withOpacity(0.08)),
              ),
            ),

            //small circle
            Positioned(
              left: 10,
              top: 10,
              child: Container(
                height: 181,
                width: 181,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kLightSecondaryColor.withOpacity(0.15)),
              ),
            ),

            //Food Image
            Positioned(
              top: 0,
              left: -50,
              child: Container(
                height: 184,
                width: 276,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image))),
              ),
            ),

            //price
            Positioned(
              top: 80,
              right: 20,
              child: Text(
                '\€$price',
                style: TextStyle(
                    color: kLightSecondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Positioned(
                top: 198,
                left: 35,
                child: Container(
                  width: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Con $ingredients',
                        style: TextStyle(
                            color: kTextColor.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        description,
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '$calories',
                        style: TextStyle(color: kTextColor),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
