import 'package:cinema_food/modules/cart_card.dart';
import 'package:cinema_food/shared/page_title.dart';
import 'package:flutter/material.dart';
import 'package:darq/darq.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<CartCard>> futureFoodList;

  @override
  void initState() {
    super.initState();
    futureFoodList = fetchCartList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: PageTitle(
                title: 'Il tuo carrello',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<List<CartCard>>(
              future: futureFoodList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CartCard> foods = snapshot.data;
                  //var uniqueFoods = foods.distinct((d) => d.productId).toList();

                  if (snapshot.data.length == 0) {
                    return Center(
                      heightFactor: 15,
                      widthFactor: 10,
                      child: Text(
                        'Il tuo carrello è vuoto 😣',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          CartCard fc = foods[index];

                          return fc;
                          /*return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(fc.image),
                            ),
                            title: Text(fc.title),
                          );*/
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("Errore: ${snapshot.error}");
                } else {
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
