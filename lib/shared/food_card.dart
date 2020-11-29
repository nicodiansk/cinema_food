import 'package:cinema_food/shared/constants.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String ingredient;
  final String image;
  final int price;
  final String calories;
  final String description;

  final Function press;

  const FoodCard(
      {Key key,
      this.title,
      this.ingredient,
      this.image,
      this.price,
      this.calories,
      this.description,
      this.press})
      : super(key: key);

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
              bottom: 0,
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
                    image: DecorationImage(image: AssetImage(image))),
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
                        'Con $ingredient',
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
                        calories,
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
