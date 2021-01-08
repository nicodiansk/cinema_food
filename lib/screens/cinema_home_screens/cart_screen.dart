import 'dart:convert';

import 'package:cinema_food/modules/cart_card.dart';
import 'package:cinema_food/modules/ticket.dart';
import 'package:cinema_food/shared/constants.dart';
import 'package:cinema_food/shared/page_title.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Future<List<CartCard>> futureFoodList;
  Future<List<Ticket>> futureTicketList;
  String tick;
  @override
  void initState() {
    super.initState();
    futureFoodList = fetchCartList();
    futureTicketList = fetchTicketList();
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
            FutureBuilder<List<Ticket>>(
              future: futureTicketList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(100),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Container(
                              width: 300,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  dropdownColor: Colors.purple[100],
                                  hint: Text(
                                    'Seleziona un biglietto',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  value: tick,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      tick = newValue;
                                    });
                                  },
                                  items: snapshot.data.map((ticket) {
                                    return DropdownMenuItem<String>(
                                      child: Text(
                                          '${ticket.filmId}\n${ticket.showTime}'),
                                      value: ticket.filmId,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
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
