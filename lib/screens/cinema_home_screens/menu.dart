import 'package:cinema_food/screens/cinema_home_screens/menu_screens/details_menu.dart';
import 'package:cinema_food/shared/category_title.dart';
import 'package:cinema_food/shared/food_card.dart';
import 'package:cinema_food/shared/page_title.dart';
import 'package:cinema_food/shared/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: PageTitle(
                title: 'Tutto il cibo che vuoi \nlo trovi qui',
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CategoryTitle(title: 'Cibo', active: true),
                  CategoryTitle(title: 'Bevande'),
                  CategoryTitle(title: 'Dolci'),
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                width: double.infinity,
                height: 50,
                child: TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Cerca qualcosa!',
                        prefixIcon: Icon(Icons.search_sharp)))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FoodCard(
                    press: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailsScreen();
                        },
                      ));
                    },
                    title: 'Insalata',
                    ingredient: 'foglie di Ale Delle Foglie',
                    image: 'assets/images/image_1.png',
                    price: 10,
                    calories: '400',
                    description:
                        'Provaaaaaaaa thge hgahte rath arth arth arh arth srthr sthrtju6u ju jku j rgegw gw g',
                  ),
                  FoodCard(
                    press: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailsScreen();
                        },
                      ));
                    },
                    title: 'Insalata',
                    ingredient: 'foglie di Ale Delle Foglie',
                    image: 'assets/images/image_2.png',
                    price: 10,
                    calories: '400',
                    description:
                        'Provaaaaaaaa thge hgahte rath arth arth arh arth srthr sthrtju6u ju jku j rgegw gw g',
                  ),

                  //sized box for the end of the children
                  SizedBox(width: 20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
