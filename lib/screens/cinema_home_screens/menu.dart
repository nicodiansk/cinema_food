import 'package:cinema_food/screens/cinema_home_screens/menu_screens/details_menu.dart';
import 'package:cinema_food/shared/category_title.dart';
import 'package:cinema_food/shared/food_card.dart';
import 'package:cinema_food/shared/page_title.dart';
import 'package:cinema_food/shared/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<List<FoodCard>> futureFoodList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFoodList = fetchFoodList();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
                CategoryTitle(title: 'Dolci'),
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
          FutureBuilder<List<FoodCard>>(
            future: futureFoodList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<FoodCard> foods = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      FoodCard fc = foods[index];
                      return fc;
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Errore: ${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}