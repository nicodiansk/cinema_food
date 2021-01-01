import 'package:cinema_food/screens/cinema_home_screens/menu_screens/details_menu.dart';
import 'package:cinema_food/shared/category_title.dart';
import 'package:cinema_food/modules/food_card.dart';
import 'package:cinema_food/shared/page_title.dart';
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
    super.initState();
    futureFoodList = fetchFoodList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: PageTitle(
                title: 'Tutto il cibo che vuoi \nlo trovi qui',
              ),
            ),
            CategoriesScroller(),
            /*SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CategoryTitle(title: 'Tutti', active: true),
                  CategoryTitle(title: 'Cibo'),
                  CategoryTitle(title: 'Bevande'),
                  CategoryTitle(title: 'Dolci'),
                ],
              ),
            ),*/
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
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        FoodCard fc = foods[index];
                        fc.press = () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsScreen(
                              productId: fc.productId,
                              title: fc.title,
                              category: fc.category,
                              size: fc.size,
                              ingredients: fc.ingredients,
                              image: fc.image,
                              price: fc.price,
                              calories: fc.calories,
                              description: fc.description,
                            );
                          }));
                        };
                        return fc;
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Errore: ${snapshot.error}");
                } else {
                  print('QUI');
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CategoryTitle(title: 'Tutti', active: true),
                CategoryTitle(title: 'Cibo'),
                CategoryTitle(title: 'Bevande'),
                CategoryTitle(title: 'Dolci'),
              ],
            ),
          ),
        ));
  }
}
