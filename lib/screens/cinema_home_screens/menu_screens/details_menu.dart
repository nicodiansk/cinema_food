import 'package:cinema_food/screens/cinema_home_screens/cart.dart';
import 'package:cinema_food/shared/avatar.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final int productId;
  final String title;
  final String category;
  final String size;
  final String ingredients;
  final String image;
  final double price;
  final double calories;
  final String description;

  DetailsScreen({
    @required this.productId,
    @required this.title,
    @required this.category,
    @required this.size,
    @required this.ingredients,
    @required this.image,
    @required this.price,
    @required this.calories,
    @required this.description,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var countBag = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                Icon(Icons.menu),
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                padding: EdgeInsets.all(6),
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kLightSecondaryColor.withOpacity(0.4),
                ),
                child: FoodAvatar(widget
                    .image) /*Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),*/
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.title}\n",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      TextSpan(
                        text: "${widget.ingredients}",
                        style: TextStyle(
                          color: kTextColor.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\€ ${widget.price}",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kLightSecondaryColor),
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              "${widget.description}",
              maxLines: 4,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      ButtonTheme(
                        minWidth: 140,
                        child: RaisedButton.icon(
                            onPressed: () {
                              setState(() {
                                countBag++;
                              });
                            },
                            color: Colors.purple[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Add to bag!',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      ButtonTheme(
                        minWidth: 140,
                        child: RaisedButton.icon(
                            onPressed: () {
                              setState(() {
                                countBag > 0 ? countBag-- : null;
                              });
                            },
                            color: kLightPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Remove one!',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple[300],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                          ),
                          color: Colors.black,
                          splashColor: Colors.lightBlueAccent,
                        ),
                        Positioned(
                          right: 15,
                          bottom: 10,
                          child: Container(
                            alignment: Alignment.center,
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Text(
                              "$countBag",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                      color: kLightSecondaryColor,
                                      fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
